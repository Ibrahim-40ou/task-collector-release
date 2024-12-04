import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../utils/common_functions.dart';

@RoutePage()
class DetailsNavigatorPage extends StatelessWidget {
  const DetailsNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    CommonFunctions().changeStatusBarColor(false, isDarkMode, context, null);
    return const AutoRouter();
  }
}
