import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                title: 'Forgot',
                onTap: () {
                  auth
                      .sendPasswordResetEmail(
                          email: emailController.text.toString())
                      .then((value) {
                    context.flushBarSuccessMessage(
                        message:
                            'We have sent you email to recover password, please check email');
                  }).onError(
                    (error, stackTrace) {
                      context.flushBarErrorMessage(
                        message: error.toString(),
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}