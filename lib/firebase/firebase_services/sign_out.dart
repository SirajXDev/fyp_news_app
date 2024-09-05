import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/firebase/Firebase_Auth_view/login_screen.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';

class Logout {
  static final auth = FirebaseAuth.instance;

  static Future<void> userSignOut(BuildContext context) async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      debugPrint(e.toString());
      context.flushBarErrorMessage(message: e.toString());
    }
  }
}
