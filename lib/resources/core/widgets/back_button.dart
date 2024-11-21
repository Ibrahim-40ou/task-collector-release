import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';

import 'button.dart';

class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final Function? function;
  final bool isMap;

  const CustomBackButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.function,
    this.isMap = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      function: () {
        if(isMap) {
          function!();
          return;
        }
        context.router.popForced(true);
        if (function != null) {
          function!();
        }
      },
      color: backgroundColor != null
          ? backgroundColor!
          : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      width: 6.h,
      height: 6.h,
      child: Icon(
        CupertinoIcons.back,
        color: iconColor != null
            ? iconColor!
            : Theme.of(context).textTheme.bodyMedium!.color,
      ),
    );
  }
}
