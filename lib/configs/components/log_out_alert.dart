import 'package:flutter/material.dart';
import 'package:news_application_2/utils/utils.dart';

Widget logoutAlert({
  required BuildContext context,
  void Function()? onLogoutPressed,
  void Function()? onCancelPressed,
}) {
  return AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.outline,
    title: const TitleTextThemeWidget(
      title: 'User Logout Dialogue',
      size: 16,
      weight: FontWeight.w500,
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const BodyTextThemeWidget(
            title: 'Logout',
            size: 15.5,
          ),
          onTap: onLogoutPressed,
        ),
        ListTile(
          leading: const Icon(Icons.cancel),
          title: const BodyTextThemeWidget(
            title: 'Cancel',
            size: 15.5,
          ),
          onTap: onCancelPressed,
        ),
      ],
    ),
  );
}
