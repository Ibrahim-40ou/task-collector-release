// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/cupertino.dart' as _i19;
import 'package:flutter/material.dart' as _i17;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i18;
import 'package:tasks_collector/resources/core/routing/pages/app.dart' as _i2;
import 'package:tasks_collector/resources/core/routing/pages/initial_route.dart'
    as _i4;
import 'package:tasks_collector/resources/core/widgets/image_viewer/widget/image_viewer.dart'
    as _i3;
import 'package:tasks_collector/resources/features/auth/presentation/pages/landing.dart'
    as _i5;
import 'package:tasks_collector/resources/features/auth/presentation/pages/login.dart'
    as _i6;
import 'package:tasks_collector/resources/features/auth/presentation/pages/otp.dart'
    as _i8;
import 'package:tasks_collector/resources/features/auth/presentation/pages/register.dart'
    as _i10;
import 'package:tasks_collector/resources/features/map/presentation/pages/map.dart'
    as _i7;
import 'package:tasks_collector/resources/features/map/presentation/pages/search.dart'
    as _i11;
import 'package:tasks_collector/resources/features/statistics/presentation/pages/statistics.dart'
    as _i13;
import 'package:tasks_collector/resources/features/tasks/domain/entities/task_entity.dart'
    as _i20;
import 'package:tasks_collector/resources/features/tasks/presentation/pages/add_task.dart'
    as _i1;
import 'package:tasks_collector/resources/features/tasks/presentation/pages/task_details.dart'
    as _i14;
import 'package:tasks_collector/resources/features/tasks/presentation/pages/tasks.dart'
    as _i15;
import 'package:tasks_collector/resources/features/user_information/presentation/pages/profile.dart'
    as _i9;
import 'package:tasks_collector/resources/features/user_information/presentation/pages/settings.dart'
    as _i12;

/// generated route for
/// [_i1.AddTaskPage]
class AddTaskRoute extends _i16.PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          AddTaskRoute.name,
          args: AddTaskRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AddTaskRouteArgs>(orElse: () => const AddTaskRouteArgs());
      return _i1.AddTaskPage(key: args.key);
    },
  );
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.AppPage]
class AppRoute extends _i16.PageRouteInfo<AppRouteArgs> {
  AppRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          AppRoute.name,
          args: AppRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AppRouteArgs>(orElse: () => const AppRouteArgs());
      return _i2.AppPage(key: args.key);
    },
  );
}

class AppRouteArgs {
  const AppRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'AppRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.ImageViewerPage]
class ImageViewerRoute extends _i16.PageRouteInfo<ImageViewerRouteArgs> {
  ImageViewerRoute({
    _i17.Key? key,
    required List<String> imageUrls,
    int initialIndex = 0,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ImageViewerRoute.name,
          args: ImageViewerRouteArgs(
            key: key,
            imageUrls: imageUrls,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageViewerRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageViewerRouteArgs>();
      return _i3.ImageViewerPage(
        key: args.key,
        imageUrls: args.imageUrls,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class ImageViewerRouteArgs {
  const ImageViewerRouteArgs({
    this.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  final _i17.Key? key;

  final List<String> imageUrls;

  final int initialIndex;

  @override
  String toString() {
    return 'ImageViewerRouteArgs{key: $key, imageUrls: $imageUrls, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i4.InitialScreen]
class InitialRoute extends _i16.PageRouteInfo<void> {
  const InitialRoute({List<_i16.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.InitialScreen();
    },
  );
}

/// generated route for
/// [_i5.LandingPage]
class LandingRoute extends _i16.PageRouteInfo<void> {
  const LandingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.LandingPage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i6.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.MapPage]
class MapRoute extends _i16.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    _i17.Key? key,
    required _i18.LatLng currentPosition,
    required bool isForShow,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            key: key,
            currentPosition: currentPosition,
            isForShow: isForShow,
          ),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MapRouteArgs>();
      return _i7.MapPage(
        key: args.key,
        currentPosition: args.currentPosition,
        isForShow: args.isForShow,
      );
    },
  );
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    required this.currentPosition,
    required this.isForShow,
  });

  final _i17.Key? key;

  final _i18.LatLng currentPosition;

  final bool isForShow;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, currentPosition: $currentPosition, isForShow: $isForShow}';
  }
}

/// generated route for
/// [_i8.OTPPage]
class OTPRoute extends _i16.PageRouteInfo<OTPRouteArgs> {
  OTPRoute({
    _i17.Key? key,
    required String phoneNumber,
    required bool registering,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          OTPRoute.name,
          args: OTPRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
            registering: registering,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPRouteArgs>();
      return _i8.OTPPage(
        key: args.key,
        phoneNumber: args.phoneNumber,
        registering: args.registering,
      );
    },
  );
}

class OTPRouteArgs {
  const OTPRouteArgs({
    this.key,
    required this.phoneNumber,
    required this.registering,
  });

  final _i17.Key? key;

  final String phoneNumber;

  final bool registering;

  @override
  String toString() {
    return 'OTPRouteArgs{key: $key, phoneNumber: $phoneNumber, registering: $registering}';
  }
}

/// generated route for
/// [_i9.ProfileInformationPage]
class ProfileInformationRoute
    extends _i16.PageRouteInfo<ProfileInformationRouteArgs> {
  ProfileInformationRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ProfileInformationRoute.name,
          args: ProfileInformationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileInformationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileInformationRouteArgs>(
          orElse: () => const ProfileInformationRouteArgs());
      return _i9.ProfileInformationPage(key: args.key);
    },
  );
}

class ProfileInformationRouteArgs {
  const ProfileInformationRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'ProfileInformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.RegisterPage]
class RegisterRoute extends _i16.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i19.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i10.RegisterPage(key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.SearchPage]
class SearchRoute extends _i16.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SearchRouteArgs>(orElse: () => const SearchRouteArgs());
      return _i11.SearchPage(key: args.key);
    },
  );
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i16.PageRouteInfo<void> {
  const SettingsRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsPage();
    },
  );
}

/// generated route for
/// [_i13.StatisticsPage]
class StatisticsRoute extends _i16.PageRouteInfo<StatisticsRouteArgs> {
  StatisticsRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          StatisticsRoute.name,
          args: StatisticsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'StatisticsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StatisticsRouteArgs>(
          orElse: () => const StatisticsRouteArgs());
      return _i13.StatisticsPage(key: args.key);
    },
  );
}

class StatisticsRouteArgs {
  const StatisticsRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'StatisticsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.TaskDetailsPage]
class TaskDetailsRoute extends _i16.PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({
    _i17.Key? key,
    required _i20.TaskEntity task,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          TaskDetailsRoute.name,
          args: TaskDetailsRouteArgs(
            key: key,
            task: task,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskDetailsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailsRouteArgs>();
      return _i14.TaskDetailsPage(
        key: args.key,
        task: args.task,
      );
    },
  );
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({
    this.key,
    required this.task,
  });

  final _i17.Key? key;

  final _i20.TaskEntity task;

  @override
  String toString() {
    return 'TaskDetailsRouteArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [_i15.TasksPage]
class TasksRoute extends _i16.PageRouteInfo<TasksRouteArgs> {
  TasksRoute({
    _i17.Key? key,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          TasksRoute.name,
          args: TasksRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<TasksRouteArgs>(orElse: () => const TasksRouteArgs());
      return _i15.TasksPage(key: args.key);
    },
  );
}

class TasksRouteArgs {
  const TasksRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'TasksRouteArgs{key: $key}';
  }
}
