import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';
import 'package:tasks_collector/resources/core/widgets/text.dart';
import 'package:tasks_collector/resources/features/tasks/domain/entities/task_entity.dart';

import '../../features/tasks/presentation/state/bloc/tasks_bloc.dart';
import '../../features/tasks/presentation/state/cubit/counter_opacity_cubit.dart';
import '../../features/tasks/presentation/state/cubit/image_counter_cubit.dart';
import '../routing/routes.gr.dart';
import '../services/internet_services.dart';
import '../utils/common_functions.dart';
import 'button.dart';
import 'loading_indicator.dart';

class CustomTask extends StatelessWidget {
  final TaskEntity task;
  final bool isDarkMode;
  final int index;
  final ImageCounterCubit pageCubit;
  final bool isStatistic;
  final pageController = PageController();
  final counterOpacityCubit = CounterOpacityCubit();
  Timer? timer;

  CustomTask({
    super.key,
    required this.task,
    required this.isDarkMode,
    required this.index,
    required this.pageCubit,
    required this.isStatistic,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          TaskDetailsRoute(task: task),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 1.h, left: 2.5.w, right: 2.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
              : Theme.of(context).colorScheme.secondary.withOpacity(0.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: '${CommonFunctions().getStatus(task.statusId)}_1'
                          .tr(),
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.w600,
                      size: 6.sp,
                    ),
                    CustomText(
                      text: ' | ',
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.w600,
                      size: 6.sp,
                    ),
                    CommonFunctions().getUploadStatusIcon(
                      task.uploadStatus,
                      context,
                    ),
                  ],
                ),
                isStatistic
                    ? Container()
                    : SizedBox(
                        height: 2.h,
                        width: 4.w,
                        child: BlocBuilder<TasksBloc, TasksStates>(
                          builder: (context, loadingState) {
                            return PopupMenuButton(
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    child: CustomButton(
                                      function: () {
                                        context.read<TasksBloc>().add(
                                              DeleteTask(
                                                id: task.id,
                                                index: index,
                                              ),
                                            );
                                        context.router.popForced();
                                      },
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      disabled:
                                          loadingState is DeleteTaskLoading,
                                      child: loadingState is DeleteTaskLoading
                                          ? CustomLoadingIndicator(
                                              color: isDarkMode
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color!
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                            )
                                          : CustomText(
                                              text: 'delete'.tr(),
                                              color: isDarkMode
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                            ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: CustomButton(
                                      function: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text:
                                                'http://tasks-collector-66a94.firebaseapp.com/app/tasksNavigator/details/${task.id}',
                                          ),
                                        );
                                        CommonFunctions().showSnackBar(context,
                                            'link copied to clipboard'.tr());
                                        context.router.popForced();
                                      },
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      disabled:
                                          loadingState is DeleteTaskLoading,
                                      child: CustomText(
                                        text: 'copy link'.tr(),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ];
                              },
                            );
                          },
                        ),
                      ),
              ],
            ),
            SizedBox(height: 1.h),
            CustomText(
              text: task.description,
              size: 5.sp,
            ),
            SizedBox(height: 1.h),
            SizedBox(
              height: 25.h,
              width: 100.w,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    itemCount: task.media.length,
                    onPageChanged: (pageIndex) {
                      pageCubit.changeImage(pageIndex);
                      counterOpacityCubit.showCounter();
                      timer?.cancel();
                      timer = Timer(
                        Duration(seconds: 2),
                        () => counterOpacityCubit.hideCounter(),
                      );
                    },
                    itemBuilder: (context, mediaIndex) {
                      return GestureDetector(
                        onTap: () {
                          context.router.push(
                            ImageViewerRoute(
                              imageUrls: task.media,
                              initialIndex: mediaIndex,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: task.media[mediaIndex].contains('http')
                                ? CachedNetworkImage(
                                    imageUrl: task.media[mediaIndex],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CustomLoadingIndicator(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Icon(Icons.error),
                                    ),
                                  )
                                : Image.file(
                                    File(task.media[mediaIndex]),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Center(child: Icon(Icons.error)),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Page Counter
                  BlocBuilder<ImageCounterCubit, int>(
                    bloc: pageCubit,
                    builder: (context, pageIndex) {
                      return BlocBuilder<CounterOpacityCubit, double>(
                        bloc: counterOpacityCubit,
                        builder: (context, opacity) {
                          return Positioned(
                            bottom: 1.h,
                            right: 2.w,
                            child: AnimatedOpacity(
                              opacity: opacity,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.w,
                                  horizontal: 2.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomText(
                                  text: '${pageIndex + 1}/${task.media.length}',
                                  color: Colors.white,
                                  size: 4.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  function: () async {
                    if (await InternetServices().isInternetAvailable()) {
                      CommonFunctions().handlePermission(
                        key: 'location',
                        context: context,
                        onGranted: () {
                          context.router.push(
                            MapRoute(
                              currentPosition: LatLng(
                                double.parse(task.lat),
                                double.parse(task.lng),
                              ),
                              isForShow: true,
                            ),
                          );
                        },
                        isForShow: true,
                      );
                    } else {
                      CommonFunctions().showDialogue(
                        context,
                        'please connect to the internet to open the map',
                        '',
                        () {},
                        () {},
                      );
                    }
                  },
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 6.w,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      SizedBox(width: 2.w),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 70.w),
                        child: CustomText(
                          text: task.address,
                          size: 4.5.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(
                  text: CommonFunctions().formatDate(task.date),
                  size: 4.5.sp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
