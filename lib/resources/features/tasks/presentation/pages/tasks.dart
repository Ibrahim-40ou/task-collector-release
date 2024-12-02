import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax/iconsax.dart';
import 'package:tasks_collector/resources/core/routing/routes.gr.dart';
import 'package:tasks_collector/resources/core/services/internet_services.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';
import 'package:tasks_collector/main.dart';
import 'package:tasks_collector/resources/core/widgets/task.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/text.dart';
import '../../domain/entities/task_entity.dart';
import '../state/bloc/tasks_bloc.dart';
import '../state/cubit/image_counter_cubit.dart';
import '../widgets/shimmer_container.dart';

@RoutePage()
class TasksPage extends StatelessWidget {
  late List<TaskEntity> tasks = [];

  TasksPage({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (preferences!.getString('deepLink') != null) {
          AutoRouter.of(context)
              .push(TaskDetailsRoute(id: preferences!.getString('deepLink')));
          preferences!.remove('deepLink');
        }
      },
    );
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: Theme.of(context).colorScheme.primary,
          onRefresh: () async {
            context.read<TasksBloc>().add(SerializationEvent());
          },
          child: BlocConsumer<TasksBloc, TasksStates>(
            listener: (BuildContext context, state) {
              if (state is DeleteTaskFailure) {
                CommonFunctions().showDialogue(
                  context,
                  state.failure!,
                  '',
                  () {},
                  () {},
                );
              }
            },
            builder: (BuildContext context, state) {
              if (state is FetchTasksSuccess) {
                tasks = state.tasks;
              }
              if (state is UploadedOfflineTasksLoading) {
                return _buildLoadingWidget(context);
              } else if (state is DeletedOfflineTasksLoading) {
                return _buildLoadingWidget(context);
              } else if (state is FetchTasksLoading) {
                return _buildLoadingWidget(context);
              } else if (state is FetchTasksFailure) {
                return _buildErrorMessage(context, state);
              } else {
                tasks = state is FetchTasksSuccess ? state.tasks : [];
                List<ImageCounterCubit> pageCubits = state is FetchTasksSuccess
                    ? List.generate(
                        tasks.length,
                        (index) => ImageCounterCubit(),
                      )
                    : [];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitles(context),
                    if (tasks.isEmpty) ...[
                      _buildNoTasks(context),
                    ],
                    _buildTasks(
                      context,
                      tasks,
                      isDarkMode,
                      pageCubits,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNoTasks(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: CustomText(
                text: 'there are no tasks. try refreshing the page'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'tasks'.tr(),
              size: 8.sp,
              weight: FontWeight.w500,
            ),
            SizedBox(height: 2.h),
            CustomTasksShimmer(),
            SizedBox(height: 1.h),
            CustomTasksShimmer(),
            SizedBox(height: 1.h),
            CustomTasksShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(
    BuildContext context,
    FetchTasksFailure state,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'failed to fetch tasks:'.tr(),
            overflow: TextOverflow.visible,
          ),
          CustomText(
            text: ' ${state.failure}',
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }

  Widget _buildTitles(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'tasks'.tr(),
            size: 8.sp,
            weight: FontWeight.w500,
          ),
          CustomButton(
            function: () async {
              if (!(await InternetServices().isInternetAvailable())) {
                if (preferences!.getString('latToAdd') == null) {
                  CommonFunctions().showDialogue(
                    context,
                    'there is no internet connection and there is not any last known location for you. try connecting to the internet',
                    '',
                    () {},
                    () {},
                  );
                } else {
                  CommonFunctions().handlePermission(
                    key: 'location',
                    context: context,
                    onGranted: () async {
                      await context.router.push(AddTaskRoute());
                    },
                  );
                }
                return;
              }
              CommonFunctions().handlePermission(
                key: 'location',
                context: context,
                onGranted: () async {
                  await context.router.push(AddTaskRoute());
                },
              );
            },
            height: 8.w,
            width: 8.w,
            color: Theme.of(context).colorScheme.surface,
            child: Icon(
              Iconsax.add,
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              size: 8.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasks(
    BuildContext context,
    List<TaskEntity> tasks,
    bool isDarkMode,
    List<ImageCounterCubit> pageCubits,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          tasks.sort(
            (a, b) {
              DateTime dateA = DateTime.parse(a.date);
              DateTime dateB = DateTime.parse(b.date);
              return dateB.compareTo(dateA);
            },
          );

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
            child: CustomTaskCard(
              task: tasks[index],
              isDarkMode: isDarkMode,
              index: index,
              pageCubit: pageCubits[index],
              isStatistic: false,
            ),
          );
        },
      ),
    );
  }
}
