import 'package:auto_route/auto_route.dart';
import 'package:tasks_collector/resources/core/routing/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: LandingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: OTPRoute.page),
        AutoRoute(page: AppRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: StatisticsRoute.page),
        AutoRoute(page: ProfileInformationRoute.page),
        AutoRoute(page: TasksRoute.page),
        AutoRoute(page: AddTaskRoute.page),
        AutoRoute(page: ImageViewerRoute.page),
        AutoRoute(page: TaskDetailsRoute.page),
      ];
}