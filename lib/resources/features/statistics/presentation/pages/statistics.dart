import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';
import 'package:tasks_collector/resources/core/widgets/task.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/text.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/presentation/state/bloc/tasks_bloc.dart';
import '../../../tasks/presentation/state/cubit/image_counter_cubit.dart';
import '../../../tasks/presentation/widgets/shimmer_container.dart';
import '../state/statistics_bloc.dart';
import '../widgets/statistic.dart';

@RoutePage()
class StatisticsPage extends StatelessWidget {
  late bool _totalTasks = true;
  late List<TaskEntity> tasks = [];

  StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    return BlocProvider<StatisticsBloc>(
      create: (context) => StatisticsBloc(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(2.w),
            child: BlocConsumer<StatisticsBloc, StatisticsStates>(
              listener:
                  (BuildContext context, StatisticsStates statisticsState) {},
              builder:
                  (BuildContext context, StatisticsStates statisticsState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitles(),
                    SizedBox(height: 1.h),
                    BlocBuilder<TasksBloc, TasksStates>(
                      builder: (
                        BuildContext context,
                        TasksStates tasksState,
                      ) {
                        if (tasksState is FetchTasksSuccess) {
                          tasks = tasksState.tasks;
                        }
                        List<ImageCounterCubit> pageCubits = List.generate(
                          tasks.length,
                          (index) => ImageCounterCubit(),
                        );
                        return Expanded(
                          child: ListView(
                            children: [
                              _buildStatistics(
                                context,
                                isDarkMode,
                                statisticsState,
                                tasks,
                              ),
                              SizedBox(height: 1.h),
                              if (tasksState is FetchTasksLoading) ...[
                                _buildLoadingWidget(context)
                              ],
                              if (tasksState
                                  is UploadedOfflineTasksLoading) ...[
                                _buildLoadingWidget(context)
                              ],
                              if (tasksState is DeletedOfflineTasksLoading) ...[
                                _buildLoadingWidget(context)
                              ],
                              _buildTasks(
                                context,
                                isDarkMode,
                                pageCubits,
                                statisticsState is TotalTasks
                                    ? statisticsState.tasks
                                    : statisticsState is ApprovedTasks
                                        ? statisticsState.tasks
                                        : statisticsState is PendingTasks
                                            ? statisticsState.tasks
                                            : statisticsState is RejectedTasks
                                                ? statisticsState.tasks
                                                : statisticsState
                                                        is ProcessingTasks
                                                    ? statisticsState.tasks
                                                    : tasks,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTasksShimmer(),
          SizedBox(height: 1.h),
          CustomTasksShimmer(),
          SizedBox(height: 1.h),
          CustomTasksShimmer(),
        ],
      ),
    );
  }

  Widget _buildTitles() {
    return CustomText(
      text: 'statistics'.tr(),
      size: 8.sp,
      weight: FontWeight.w500,
    );
  }

  Widget _buildStatistics(
    BuildContext context,
    bool isDarkMode,
    StatisticsStates state,
    List<TaskEntity> tasks,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomStatistic(
          width: 100.w,
          icon: Iconsax.book,
          title: 'total tasks'.tr(),
          number: '${tasks.length}',
          function: () {
            context.read<StatisticsBloc>().add(
                  TotalTasksEvent(tasks: tasks),
                );
            _totalTasks = true;
          },
          selected: state is TotalTasks || _totalTasks,
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStatistic(
              width: null,
              icon: Iconsax.tick_circle,
              title: 'done_2',
              number:
                  '${tasks.where((task) => task.statusId == 4).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      ApprovedTasksEvent(tasks: tasks),
                    );
                _totalTasks = false;
              },
              selected: state is ApprovedTasks,
            ),
            SizedBox(width: 2.w),
            CustomStatistic(
              width: null,
              icon: Iconsax.info_circle,
              title: 'pending_2',
              number:
                  '${tasks.where((task) => task.statusId == 1).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      PendingTasksEvent(tasks: tasks),
                    );
                _totalTasks = false;
              },
              selected: state is PendingTasks,
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomStatistic(
              width: null,
              icon: Iconsax.close_circle,
              title: 'canceled_2',
              number:
                  '${tasks.where((task) => task.statusId == 3).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      RejectedTasksEvent(tasks: tasks),
                    );
                _totalTasks = false;
              },
              selected: state is RejectedTasks,
            ),
            SizedBox(width: 2.w),
            CustomStatistic(
              width: null,
              icon: Iconsax.activity,
              title: 'in progress_2',
              number:
                  '${tasks.where((task) => task.statusId == 2).toList().length}',
              function: () {
                context.read<StatisticsBloc>().add(
                      ProcessingTasksEvent(tasks: tasks),
                    );
                _totalTasks = false;
              },
              selected: state is ProcessingTasks,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTasks(
    BuildContext context,
    bool isDarkMode,
    List<ImageCounterCubit> pageCubits,
    List<TaskEntity> tasks,
  ) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        tasks.sort(
          (a, b) {
            DateTime dateA = DateTime.parse(a.date);
            DateTime dateB = DateTime.parse(b.date);
            return dateB.compareTo(dateA);
          },
        );
        return CustomTask(
          task: tasks[index],
          isDarkMode: isDarkMode,
          index: index,
          pageCubit: pageCubits[index],
          isStatistic: false,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 1.h);
      },
    );
  }
}
