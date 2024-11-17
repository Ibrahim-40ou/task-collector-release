import 'package:flutter/material.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color color;

  const CustomLoadingIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6.w,
      width: 6.w,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
      ),
    );
  }
}
