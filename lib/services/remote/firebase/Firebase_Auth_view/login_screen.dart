import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/main.dart';
import 'package:news_application_2/services/remote/firebase/Firebase_Auth_view/forgot_password.dart';
import 'package:news_application_2/services/remote/firebase/Firebase_Auth_view/login_with_phone.dart';
import 'package:news_application_2/services/remote/firebase/Firebase_Auth_view/signup_screen.dart';
import 'package:news_application_2/services/remote/firebase/firebase_services/firestore_helper.dart';
import 'package:news_application_2/utils/extensions/flush_bar_extension.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';
import 'package:news_application_2/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
  }

  void login(String email, String password) async {
    setState(() {
      loading = true;
    });
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) async {
      if (mounted) {
        context.flushBarSuccessMessage(
          message: userCredential.user!.email ?? '',
        );
      }

      CloudFirestoreHelper cloudfirestoreHelper = CloudFirestoreHelper();
      var docSnap = await cloudfirestoreHelper.getDocument(
          'users', userCredential.user?.uid ?? 'uid-01');
      var role = await docSnap.get('role') as String;
      // Store role in shared preferences
      var sp = getIt<SharedPreferencesHelper>();
      await sp.setString('role', role);

      if (mounted) {
        if (role.isEmpty || role == 'admin' || role == 'user') {
          nextToRepacedNamed(RoutesName.roleBasedNavigation);
        } else {
          debugPrint('Role is not defined: $role');
        }
      }
      debugPrint('currentRole: $role');

      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      if (mounted) {
        context.flushBarErrorMessage(
          message: error.toString(),
        );
      }

      setState(() {
        loading = false;
      });
    });
  }

  void nextToRepacedNamed(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('login screen'),
          backgroundColor: Colors.blue,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                          hintText: 'password',
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
                    title: 'login',
                    loading: loading,
                    onTap: () {
                      if (_formField.currentState!.validate()) {
                        login(emailController.text.trim(),
                            passwordController.text.trim());
                      }
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen()));
                      },
                      child: const Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.blue),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black)),
                  child: const Center(
                    child: Text('Login with phone'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
