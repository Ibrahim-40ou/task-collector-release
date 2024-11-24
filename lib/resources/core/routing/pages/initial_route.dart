import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import '../../../features/tasks/presentation/state/bloc/tasks_bloc.dart';
import '../../../features/user_information/presentation/state/bloc/user_information_bloc.dart';
import '../../widgets/loading_indicator.dart';
import '../routes.gr.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool loggedIn = preferences!.getBool('loggedIn') ?? false;
    if (loggedIn) {
      context.read<UserInformationBloc>().add(UserLogoutEvent());
      context.read<TasksBloc>().add(TasksLogout());
      context.read<TasksBloc>().add(SerializationEvent(isPagination: false));
      context.read<UserInformationBloc>().add(SerializationUserEvent());

      context.router.replaceAll([AppRoute()]);
    } else {
      context.router.replaceAll([LandingRoute()]);
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CustomLoadingIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
