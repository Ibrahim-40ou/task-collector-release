import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_collector/firebase_options.dart';
import 'package:tasks_collector/resources/core/utils/image_selection_state/image_selection_bloc.dart';
import 'resources/core/routing/routes.dart';
import 'resources/core/sizing/size_config.dart';
import 'resources/core/theme/theme.dart';
import 'resources/core/theme/theme_state/theme_bloc.dart';
import 'resources/core/utils/common_functions.dart';
import 'resources/core/widgets/image_viewer/state/cubit/image_viewer_cubit.dart';
import 'resources/features/auth/presentation/state/bloc/auth_bloc.dart';
import 'resources/features/auth/presentation/state/cubit/timer_cubit.dart';
import 'resources/features/tasks/presentation/state/bloc/tasks_bloc.dart';
import 'resources/features/tasks/presentation/state/cubit/image_counter_cubit.dart';
import 'resources/features/user_information/presentation/state/bloc/user_information_bloc.dart';

SharedPreferences? preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      path: 'assets/translations',
      saveLocale: true,
      startLocale: CommonFunctions().getStartingLanguage(),
      fallbackLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc()
              ..add(
                LoadTheme(
                  isDarkMode:
                      preferences!.getString('theme') == 'dark' ? true : false,
                ),
              ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<UserInformationBloc>(
            create: (context) =>
                UserInformationBloc()..add(SerializationUserEvent()),
          ),
          BlocProvider<TimerCubit>(
            create: (context) => TimerCubit(),
          ),
          BlocProvider<ImageViewerCubit>(
            create: (_) => ImageViewerCubit(0),
          ),
          BlocProvider<ImageCounterCubit>(
            create: (BuildContext context) => ImageCounterCubit(),
          ),
          BlocProvider<ImageSelectionBloc>(
            create: (BuildContext context) => ImageSelectionBloc(),
          ),
          BlocProvider<TasksBloc>(
            create: (BuildContext context) =>
                TasksBloc()..add(SerializationEvent()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            SizeConfig().init(constraints);
            return MaterialApp.router(
              title: 'Tasks Collector',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routerConfig: appRouter.config(
                deepLinkBuilder: (deepLink) {
                  if (deepLink.path
                      .startsWith('/app/tasksNavigator/details/')) {
                    if (preferences!.getBool('loggedIn') != true) {
                      preferences!
                          .setString('deepLink', deepLink.path.split('/').last);
                      return DeepLink.defaultPath;
                    } else {
                      return deepLink;
                    }
                  } else {
                    return DeepLink.defaultPath;
                  }
                },
              ),
              theme: light,
              darkTheme: dark,
              themeMode: context.read<ThemeBloc>().mode,
              builder: (context, child) {
                return child!;
              },
            );
          },
        );
      },
    );
  }
}
