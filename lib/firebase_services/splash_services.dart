import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mews_application_2/Firebase_Auth/login_screen.dart';
import 'package:mews_application_2/screens/home_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    //check user is login or not
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }
}
