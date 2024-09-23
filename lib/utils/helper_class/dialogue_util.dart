// utils/dialog_utils.dart

import 'package:flutter/material.dart';

class DialogUtils {
  static void showInfoSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.blue);
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.green);
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.red);
  }

  static void showWarningSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.amber);
  }

  static void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
