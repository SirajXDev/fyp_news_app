import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/utils/utils.dart';

Widget customAlertDialog({
  void Function()? onAlert,
  void Function()? onCancel,
  Color? backgroundColor,
}) {
  return AlertDialog(
    backgroundColor: backgroundColor ?? AppColors.greenLight,
    title: const TitleTextThemeWidget(
      title: "User Logout Dialogue",
      size: 16,
      weight: FontWeight.w500,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const BodyTextThemeWidget(
            title: "Logout",
          ),
          onTap: onAlert,
        ),
        ListTile(
          leading: const Icon(Icons.cancel),
          title: const BodyTextThemeWidget(
            title: "Cancel",
          ),
          onTap: onCancel,
        ),
      ],
    ),
  );
}
