import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../widgets/loading_indicator.dart';
import '../routes.gr.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool loggedIn = preferences!.getBool('loggedIn') ?? false;
    if (loggedIn) {
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
