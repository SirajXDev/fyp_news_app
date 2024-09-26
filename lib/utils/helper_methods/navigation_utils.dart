import 'package:flutter/material.dart';

class NavigationUtils {
  static void popNavigation(BuildContext context) {
    Navigator.pop(context);
  }

  static void pushNamedAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  static void pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  static void pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(
      context,
      routeName,
    );
  }
}
