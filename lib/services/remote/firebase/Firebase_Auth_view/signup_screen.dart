import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/services/remote/firebase/firebase_services/cloud_firestore_helper.dart';
import 'package:news_application_2/utils/utils.dart';
import 'package:news_application_2/widgets/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;

  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp(String email, String password) async {
    if (_formField.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      String role = validateRole(email); // Get the updated role

      // Create user account
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) async {
        CloudFirestoreHelper cloudfirestoreHelper = CloudFirestoreHelper();
        await cloudfirestoreHelper.setDocument(
          'users',
          userCredential.user?.uid ?? 'uid-01',
          {
            'email': email,
            'role': role,
          },
          SetOptions(merge: false),
        );

        setState(() {
          loading = false;
        });

        // Navigate to another screen or show a success message here
        if (mounted) {
          Navigator.pushReplacementNamed(context, RoutesName.login);
        }
      }).catchError((error) {
        setState(() {
          loading = false;
        });
        if (mounted) {
          Utils.snackBarMessage(context, error.toString(), 15);
        }
      });
    }
  }

  String validateRole(String email) {
    if (email.endsWith('@admin.com')) {
      return 'admin';
    } else if (email.endsWith('@gmail.com')) {
      return 'user';
    } else {
      return 'moderator';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up screen'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formField,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_open),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: RoundButton(
                title: 'Sign up',
                loading: loading,
                onTap: () => signUp(emailController.text.trim(),
                    passwordController.text.trim()),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
