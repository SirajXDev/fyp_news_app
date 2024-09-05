import 'package:flutter/material.dart';

class CustomNotificationCountWidget extends StatelessWidget {
  const CustomNotificationCountWidget(
      {super.key,
      this.count,
      this.textColor,
      this.bgColor,
      this.onTap,
      required this.icon});
  final int? count;
  final Color? textColor;
  final Color? bgColor;
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Badge.count(
        count: count ?? 1,
        textColor: textColor,
        backgroundColor: bgColor,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
