import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/utils/utils.dart';

Widget imagePickAlert({
  void Function()? onCameraPressed,
  void Function()? onGalleryPressed,
  Color? backgroundColor,
}) {
  return AlertDialog(
    backgroundColor: backgroundColor ?? AppColors.greenLight,
    title: const TitleTextThemeWidget(
      title: "Pick a source:",
      size: 16,
      weight: FontWeight.w500,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const BodyTextThemeWidget(
            title: "Camera",
          ),
          onTap: onCameraPressed,
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const BodyTextThemeWidget(
            title: "Gallery",
          ),
          onTap: onGalleryPressed,
        ),
      ],
    ),
  );
}
