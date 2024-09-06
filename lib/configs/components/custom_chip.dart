import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/utils/utils.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    this.text,
    this.color,
    this.child,
  });

  final String? text;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.2),
      decoration: BoxDecoration(
        color: color ?? AppColors.orangeLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: child ?? BodyTextThemeWidget(title: text ?? "learn More.."),
    );
  }
}
