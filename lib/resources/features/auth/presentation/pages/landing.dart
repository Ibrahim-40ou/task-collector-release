import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasks_collector/main.dart';
import 'package:tasks_collector/resources/core/routing/routes.gr.dart';
import 'package:tasks_collector/resources/core/services/internet_services.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';
import 'package:tasks_collector/resources/core/widgets/loading_indicator.dart';
import 'package:tasks_collector/resources/features/auth/presentation/state/bloc/auth_bloc.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/text.dart';
import '../state/cubit/timer_cubit.dart';

@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    });
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is FetchGovernoratesSuccess) {
          if (state.isLogin) {
            context.router.push(LoginRoute());
          } else {
            context.router.push(RegisterRoute());
          }
        }
        if (state is FetchGovernoratesFailure) {
          CommonFunctions().showDialogue(
            context,
            state.failure!,
            '',
            () {},
            () {},
          );
        }
      },
      builder: (BuildContext context, AuthState state) {
        context.read<TimerCubit>().resetTimer();
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                _buildLogo(),
                _buildContainer(context, isDarkMode, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Expanded(
      child: Center(
        child: CustomText(
          text: 'TASKS COLLECTOR',
          size: 10.sp,
          weight: FontWeight.bold,
          align: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildContainer(
    BuildContext context,
    bool isDarkMode,
    AuthState state,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 35.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomText(
                      text: 'welcome to Tasks Collector'.tr(),
                      weight: FontWeight.bold,
                      size: CommonFunctions().englishCheck(context)
                          ? 7.5.sp
                          : 7.sp,
                    ),
                  ),
                ],
              ),
              CustomText(
                text:
                    'either login or register to continue and use the app'.tr(),
                color: Theme.of(context).textTheme.labelMedium!.color,
                overflow: TextOverflow.visible,
              ),
              // Spacer(),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    function: () {
                      CommonFunctions().showLanguageBottomSheet(
                        context,
                        isDarkMode,
                      );
                    },
                    width: 6.w,
                    color: Colors.transparent,
                    child: Icon(
                      Iconsax.language_square,
                      size: 6.w,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  CustomButton(
                    function: () {
                      CommonFunctions().showThemeBottomSheet(
                        context,
                        isDarkMode,
                      );
                    },
                    width: 6.w,
                    color: Colors.transparent,
                    child: Icon(
                      isDarkMode ? Iconsax.moon : Iconsax.sun_1,
                      size: 6.w,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              CustomButton(
                function: () async {
                  if (await InternetServices().isInternetAvailable()) {
                    if (preferences!.getString('governorates') != null) {
                      context.router.push(LoginRoute());
                      return;
                    }
                    context
                        .read<AuthBloc>()
                        .add(FetchGovernorates(isLogin: true));
                  } else {
                    CommonFunctions().showDialogue(
                      context,
                      'please connect to the internet to login',
                      '',
                      () {},
                      () {},
                    );
                  }
                },
                disabled: state is FetchGovernoratesLoading
                    ? state.isLogin
                        ? true
                        : false
                    : false,
                height: 6.h,
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    state is FetchGovernoratesLoading
                        ? state.isLogin
                            ? Row(
                                children: [
                                  CustomLoadingIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2.w),
                                ],
                              )
                            : Container()
                        : Container(),
                    CustomText(
                      text: 'login'.tr(),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () async {
                  if (await InternetServices().isInternetAvailable()) {
                    if (preferences!.getString('governorates') != null) {
                      context.router.push(RegisterRoute());
                      return;
                    }
                    context
                        .read<AuthBloc>()
                        .add(FetchGovernorates(isLogin: false));
                  } else {
                    CommonFunctions().showDialogue(
                      context,
                      'please connect to the internet to register',
                      '',
                      () {},
                      () {},
                    );
                  }
                },
                disabled: state is FetchGovernoratesLoading
                    ? state.isLogin
                        ? false
                        : true
                    : false,
                height: 6.h,
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    state is FetchGovernoratesLoading
                        ? state.isLogin
                            ? Container()
                            : Row(
                                children: [
                                  CustomLoadingIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2.w),
                                ],
                              )
                        : Container(),
                    CustomText(
                      text: 'register'.tr(),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
