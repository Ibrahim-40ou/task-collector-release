import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasks_collector/resources/core/services/internet_services.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';

import '../../../main.dart';
import '../theme/colors.dart';
import '../theme/theme_state/theme_bloc.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';

class CommonFunctions {
  String formatDate(String isoDateString) {
    try {
      DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'")
          .parseUTC(isoDateString)
          .toLocal();
      DateTime now = DateTime.now();

      Duration difference = now.difference(dateTime);
      int daysDifference = difference.inDays;

      if (dateTime.year == now.year) {
        if (daysDifference == 0) {
          return DateFormat.jm().format(dateTime);
        } else if (daysDifference > 0 && daysDifference <= 7) {
          return DateFormat.E().format(dateTime);
        } else {
          return DateFormat.MMMd().format(dateTime);
        }
      } else {
        return '${dateTime.year}, ${DateFormat.MMM().format(dateTime)} ${dateTime.day}';
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  Widget getUploadStatusIcon(String status, BuildContext context) {
    switch (status) {
      case 'uploaded':
        return Icon(
          Icons.done_all,
          size: 6.w,
          color: Theme.of(context).colorScheme.primary,
        );
      case 'waiting':
        return Icon(
          Icons.check,
          size: 6.w,
          color: Theme.of(context).colorScheme.primary,
        );

      default:
        return Icon(
          Icons.done_all,
          size: 6.w,
          color: Theme.of(context).colorScheme.primary,
        );
    }
  }

  Future<String> handleLocationServices() async {
    if (await InternetServices().isInternetAvailable()) {
      if (await Geolocator.isLocationServiceEnabled()) {
        return 'on';
      } else {
        return 'off';
      }
    } else {
      return 'no internet';
    }
  }

  void handlePermission({
    required String key,
    required BuildContext context,
    required Function onGranted,
    bool isForShow = false,
  }) async {
    if (key == 'location' && await Permission.location.status.isGranted) {
      if (await handleLocationServices() == 'on') {
        onGranted();
      } else if (await handleLocationServices() == 'off') {
        showDialogue(
          context,
          '',
          isForShow
              ? 'please enable location services to use the map'
              : 'to add a task, please turn on location services',
          () {},
          () {
            Geolocator.openLocationSettings();
          },
        );
      } else {
        onGranted();
      }
      return;
    } else if (key == 'camera' && await Permission.camera.status.isGranted) {
      onGranted();
      return;
    } else if (key == 'photos' && await Permission.photos.status.isGranted) {
      onGranted();
      return;
    }
    showDialogue(
      context,
      '',
      key == 'location'
          ? 'to add a task, you must permit the app to access your location'
          : key == 'camera'
              ? 'to use the camera, you must permit the app to access the camera'
              : 'to use the gallery, you must permit the app to access the gallery',
      () {},
      () async {
        if (key == 'location') {
          if (await Permission.location.status.isPermanentlyDenied) {
            await openAppSettings();
            return;
          } else if (await Permission.location.status.isDenied ||
              await Permission.location.status.isLimited) {
            await Permission.location.request();
            return;
          }
        } else if (key == 'camera') {
          if (await Permission.camera.status.isPermanentlyDenied) {
            openAppSettings();
            return;
          } else {
            Permission.camera.request();
            return;
          }
        } else if (key == 'photos') {
          if (await Permission.photos.status.isPermanentlyDenied) {
            openAppSettings();
            return;
          } else {
            Permission.photos.request();
            return;
          }
        }
      },
    );
  }

  String getStatus(int id) {
    if (id == 1) {
      return 'pending';
    } else if (id == 2) {
      return 'in progress';
    } else if (id == 3) {
      return 'canceled';
    } else if (id == 4) {
      return 'done';
    } else {
      return '';
    }
  }

  void changeLanguage(BuildContext context, String code) {
    if (code == 'en') {
      context.setLocale(const Locale('en', 'US'));
      preferences!.setString('language', 'en');
    } else {
      preferences!.setString('language', 'ar');
      context.setLocale(const Locale('ar', 'DZ'));
    }
  }

  bool darkModeCheck(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  bool englishCheck(BuildContext context) {
    return Localizations.localeOf(context).toString() == 'en_US';
  }

  Locale getStartingLanguage() {
    return preferences!.getString('language') == null ||
            preferences!.getString('language') == 'en'
        ? const Locale('en', 'US')
        : const Locale('ar', 'DZ');
  }

  void initiateSystemThemes(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        statusBarColor:
            isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  //
  // String? getGovernorateNumber(String governorateName, BuildContext context) {
  //   if (Localizations.localeOf(context).toString() == 'en_US') {
  //     return governoratesNamesMapEnglish[governorateName.toLowerCase()];
  //   } else {
  //     return governoratesNamesMapArabic[governorateName];
  //   }
  // }
  //
  // String? getGovernorateName(String? governorateNumber) {
  //   if (governorateNumber != null) {
  //     return governoratesNumbersMap[governorateNumber];
  //   } else {
  //     return null;
  //   }
  // }

  void changeStatusBarColor(
    bool isPrimary,
    bool isDarkMode,
    BuildContext context,
    Color? color,
  ) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isPrimary
            ? Theme.of(context).colorScheme.primary
            : color ?? Theme.of(context).colorScheme.surface,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isPrimary
            ? Brightness.light
            : isDarkMode
                ? Brightness.light
                : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarColor: color,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  String handleErrorMessage(String error) {
    if (error.contains('Network is unreachable')) {
      return 'a network error has occurred. please try again later.'.tr();
    } else if (error.contains('The phone has already been taken')) {
      return 'phone number already in use. please use a different one.'.tr();
    } else if (error.contains('The OTP is invalid or has expired.')) {
      return 'the OTP is invalid or has expired'.tr();
    } else if (error.contains(
        'there is no internet connection and there is not any last known location')) {
      return 'there is no internet connection and there is not any last known location for you. try connecting to the internet'
          .tr();
    } else if (error
        .contains('please wait until your current location is fetched')) {
      return 'please wait until your current location is fetched'.tr();
    } else if (error.contains('reset by peer')) {
      return 'a network error has occurred. please try again later.'.tr();
    } else if (error
        .contains('please connect to the internet to open the map')) {
      return 'please connect to the internet to open the map. last known location will be used when there is no internet'
          .tr();
    } else if (error.contains('location is off')) {
      return 'please enable location services to use the map'.tr();
    } else if (error
        .contains('The media.1 field must be a file of type: jpg, jpeg')) {
      return 'the image format for the selected photos is not supported. please use a different format'
          .tr();
    } else if (error.contains("Data too long for column 'description'")) {
      return 'description field data is too long. please use a shortened description for the task'
          .tr();
    } else {
      return 'unknown error occurred. please try again later'.tr();
    }
  }

  void showDialogue(
    BuildContext context,
    String errorText,
    String message,
    Function exitDialogue,
    Function confirmFunction,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              errorText.isNotEmpty
                  ? Container(
                      height: 10.h,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        color: Theme.of(context).colorScheme.error,
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.close_circle,
                          size: 10.w,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          top: 3.w,
                        ),
                        child: CustomText(
                          text: 'confirmation'.tr(),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: errorText.isNotEmpty
                          ? Alignment.center
                          : Alignment.centerLeft,
                      child: CustomText(
                        text: errorText.isEmpty
                            ? message.tr()
                            : 'error occurred'.tr(),
                        size: errorText.isEmpty ? null : 6.5.sp,
                        weight: errorText.isEmpty ? null : FontWeight.bold,
                      ),
                    ),
                    errorText.isEmpty ? Container() : SizedBox(height: 1.h),
                    errorText.isEmpty
                        ? Container()
                        : CustomText(
                            text: handleErrorMessage(errorText),
                          ),
                    SizedBox(height: 1.h),
                    CustomButton(
                      function: () {
                        context.router.popForced(true);
                        confirmFunction();
                      },
                      color: errorText.isEmpty
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error,
                      child: CustomText(
                        text:
                            errorText.isNotEmpty ? 'okay'.tr() : 'confirm'.tr(),
                        color: Colors.white,
                      ),
                    ),
                    errorText.isNotEmpty
                        ? Container()
                        : CustomButton(
                            border: true,
                            borderColor: Colors.black,
                            function: () {
                              context.router.popForced(true);
                              exitDialogue();
                            },
                            color: Colors.white,
                            child: CustomText(
                              text: 'cancel'.tr(),
                              color: Colors.black,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showThemeBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState state) {
            isDarkMode = state is ThemeChanged ? state.isDarkMode : isDarkMode;
            return Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: 100.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: 'theme'.tr(),
                    size: 6.sp,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3)
                          : Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(text: 'dark mode'.tr()),
                        Switch(
                          value: darkModeCheck(context),
                          onChanged: (value) {
                            context.read<ThemeBloc>().add(
                                  ChangeTheme(
                                    isDarkMode: value,
                                  ),
                                );
                          },
                          trackOutlineColor: MaterialStateProperty.all(
                            Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                          inactiveTrackColor: isDarkMode
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2)
                              : Theme.of(context).colorScheme.secondary,
                          activeTrackColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showLanguageBottomSheet(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'language'.tr(),
                size: 6.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () {
                  changeLanguage(context, 'ar');
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: 'arabic'.tr()),
                      Container(
                        height: 2.h,
                        width: 2.h,
                        padding: EdgeInsets.all(0.4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: englishCheck(context)
                                ? Colors.transparent
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              CustomButton(
                function: () {
                  changeLanguage(context, 'en');
                },
                height: 6.h,
                color: isDarkMode
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: 'english'.tr()),
                      Container(
                        height: 2.h,
                        width: 2.h,
                        padding: EdgeInsets.all(0.4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color!,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: englishCheck(context)
                                ? Theme.of(context).textTheme.bodyMedium!.color!
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String text) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          horizontal: 1.5.h,
          vertical: 5.w,
        ),
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            CustomText(
              text: text,
              weight: FontWeight.normal,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(context).textTheme.bodyMedium!.color!,
      ),
    );
  }
}
