// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/cupertino.dart' as _i23;
import 'package:flutter/material.dart' as _i21;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i22;
import 'package:tasks_collector/resources/core/routing/pages/app.dart' as _i2;
import 'package:tasks_collector/resources/core/routing/pages/initial_route.dart'
    as _i4;
import 'package:tasks_collector/resources/core/routing/pages/wrappers/landing_wrapper.dart'
    as _i5;
import 'package:tasks_collector/resources/core/routing/pages/wrappers/settings_wrapper.dart'
    as _i13;
import 'package:tasks_collector/resources/core/routing/pages/wrappers/statistics_wrapper.dart'
    as _i15;
import 'package:tasks_collector/resources/core/routing/pages/wrappers/tasks_wrapper.dart'
    as _i18;
import 'package:tasks_collector/resources/core/widgets/image_viewer/widget/image_viewer.dart'
    as _i3;
import 'package:tasks_collector/resources/features/auth/presentation/pages/landing.dart'
    as _i6;
import 'package:tasks_collector/resources/features/auth/presentation/pages/login.dart'
    as _i7;
import 'package:tasks_collector/resources/features/auth/presentation/pages/otp.dart'
    as _i9;
import 'package:tasks_collector/resources/features/auth/presentation/pages/register.dart'
    as _i11;
import 'package:tasks_collector/resources/features/map/presentation/pages/map.dart'
    as _i8;
import 'package:tasks_collector/resources/features/map/presentation/pages/search.dart'
    as _i12;
import 'package:tasks_collector/resources/features/statistics/presentation/pages/statistics.dart'
    as _i16;
import 'package:tasks_collector/resources/features/tasks/domain/entities/task_entity.dart'
    as _i24;
import 'package:tasks_collector/resources/features/tasks/presentation/pages/add_task.dart'
    as _i1;
import 'package:tasks_collector/resources/features/tasks/presentation/pages/task_details.dart'
    as _i17;
import 'package:tasks_collector/resources/features/tasks/presentation/pages/tasks.dart'
    as _i19;
import 'package:tasks_collector/resources/features/user_information/presentation/pages/profile.dart'
    as _i10;
import 'package:tasks_collector/resources/features/user_information/presentation/pages/settings.dart'
    as _i14;

/// generated route for
/// [_i1.AddTaskPage]
class AddTaskRoute extends _i20.PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          AddTaskRoute.name,
          args: AddTaskRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static _i20.PageInfo page = _i20.PageInfo(
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

  final _i21.Key? key;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.AppPage]
class AppRoute extends _i20.PageRouteInfo<AppRouteArgs> {
  AppRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          AppRoute.name,
          args: AppRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static _i20.PageInfo page = _i20.PageInfo(
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

  final _i21.Key? key;

  @override
  String toString() {
    return 'AppRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.ImageViewerPage]
class ImageViewerRoute extends _i20.PageRouteInfo<ImageViewerRouteArgs> {
  ImageViewerRoute({
    _i21.Key? key,
    required List<String> imageUrls,
    int initialIndex = 0,
    List<_i20.PageRouteInfo>? children,
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

  static _i20.PageInfo page = _i20.PageInfo(
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

  final _i21.Key? key;

  final List<String> imageUrls;

  final int initialIndex;

  @override
  String toString() {
    return 'ImageViewerRouteArgs{key: $key, imageUrls: $imageUrls, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i4.InitialScreen]
class InitialRoute extends _i20.PageRouteInfo<void> {
  const InitialRoute({List<_i20.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i4.InitialScreen();
    },
  );
}

/// generated route for
/// [_i5.LandingNavigatorPage]
class LandingNavigatorRoute extends _i20.PageRouteInfo<void> {
  const LandingNavigatorRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LandingNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingNavigatorRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i5.LandingNavigatorPage();
    },
  );
}

/// generated route for
/// [_i6.LandingPage]
class LandingRoute extends _i20.PageRouteInfo<void> {
  const LandingRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i6.LandingPage();
    },
  );
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i20.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i7.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.MapPage]
class MapRoute extends _i20.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    _i21.Key? key,
    required _i22.LatLng currentPosition,
    required bool isForShow,
    List<_i20.PageRouteInfo>? children,
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

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MapRouteArgs>();
      return _i8.MapPage(
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

  final _i21.Key? key;

  final _i22.LatLng currentPosition;

  final bool isForShow;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, currentPosition: $currentPosition, isForShow: $isForShow}';
  }
}

/// generated route for
/// [_i9.OTPPage]
class OTPRoute extends _i20.PageRouteInfo<OTPRouteArgs> {
  OTPRoute({
    _i21.Key? key,
    required String phoneNumber,
    required bool registering,
    List<_i20.PageRouteInfo>? children,
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

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPRouteArgs>();
      return _i9.OTPPage(
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

  final _i21.Key? key;

  final String phoneNumber;

  final bool registering;

  @override
  String toString() {
    return 'OTPRouteArgs{key: $key, phoneNumber: $phoneNumber, registering: $registering}';
  }
}

/// generated route for
/// [_i10.ProfileInformationPage]
class ProfileInformationRoute
    extends _i20.PageRouteInfo<ProfileInformationRouteArgs> {
  ProfileInformationRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          ProfileInformationRoute.name,
          args: ProfileInformationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileInformationRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileInformationRouteArgs>(
          orElse: () => const ProfileInformationRouteArgs());
      return _i10.ProfileInformationPage(key: args.key);
    },
  );
}

class ProfileInformationRouteArgs {
  const ProfileInformationRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'ProfileInformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.RegisterPage]
class RegisterRoute extends _i20.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i23.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i11.RegisterPage(key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i23.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.SearchPage]
class SearchRoute extends _i20.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SearchRouteArgs>(orElse: () => const SearchRouteArgs());
      return _i12.SearchPage(key: args.key);
    },
  );
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.SettingsNavigatorPage]
class SettingsNavigatorRoute extends _i20.PageRouteInfo<void> {
  const SettingsNavigatorRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SettingsNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsNavigatorRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i13.SettingsNavigatorPage();
    },
  );
}

/// generated route for
/// [_i14.SettingsPage]
class SettingsRoute extends _i20.PageRouteInfo<void> {
  const SettingsRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i14.SettingsPage();
    },
  );
}

/// generated route for
/// [_i15.StatisticsNavigatorPage]
class StatisticsNavigatorRoute extends _i20.PageRouteInfo<void> {
  const StatisticsNavigatorRoute({List<_i20.PageRouteInfo>? children})
      : super(
          StatisticsNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatisticsNavigatorRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i15.StatisticsNavigatorPage();
    },
  );
}

/// generated route for
/// [_i16.StatisticsPage]
class StatisticsRoute extends _i20.PageRouteInfo<StatisticsRouteArgs> {
  StatisticsRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          StatisticsRoute.name,
          args: StatisticsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'StatisticsRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StatisticsRouteArgs>(
          orElse: () => const StatisticsRouteArgs());
      return _i16.StatisticsPage(key: args.key);
    },
  );
}

class StatisticsRouteArgs {
  const StatisticsRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'StatisticsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.TaskDetailsPage]
class TaskDetailsRoute extends _i20.PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({
    _i21.Key? key,
    _i24.TaskEntity? task,
    String? id,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          TaskDetailsRoute.name,
          args: TaskDetailsRouteArgs(
            key: key,
            task: task,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'TaskDetailsRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TaskDetailsRouteArgs>(
          orElse: () => TaskDetailsRouteArgs(id: pathParams.optString('id')));
      return _i17.TaskDetailsPage(
        key: args.key,
        task: args.task,
        id: args.id,
      );
    },
  );
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({
    this.key,
    this.task,
    this.id,
  });

  final _i21.Key? key;

  final _i24.TaskEntity? task;

  final String? id;

  @override
  String toString() {
    return 'TaskDetailsRouteArgs{key: $key, task: $task, id: $id}';
  }
}

/// generated route for
/// [_i18.TasksNavigatorPage]
class TasksNavigatorRoute extends _i20.PageRouteInfo<void> {
  const TasksNavigatorRoute({List<_i20.PageRouteInfo>? children})
      : super(
          TasksNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksNavigatorRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      return const _i18.TasksNavigatorPage();
    },
  );
}

/// generated route for
/// [_i19.TasksPage]
class TasksRoute extends _i20.PageRouteInfo<TasksRouteArgs> {
  TasksRoute({
    _i21.Key? key,
    List<_i20.PageRouteInfo>? children,
  }) : super(
          TasksRoute.name,
          args: TasksRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static _i20.PageInfo page = _i20.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<TasksRouteArgs>(orElse: () => const TasksRouteArgs());
      return _i19.TasksPage(key: args.key);
    },
  );
}

class TasksRouteArgs {
  const TasksRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'TasksRouteArgs{key: $key}';
  }
}
