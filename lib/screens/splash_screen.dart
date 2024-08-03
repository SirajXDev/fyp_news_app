
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mews_application_2/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen=SplashServices();
  @override
  void initState(){
    super.initState();
  splashScreen.isLogin(context);

  }
  // @override
  // void initState() {
  //   super.initState();

  //   Timer(const Duration(seconds: 4), () {
  //     //here we used navigator push replacement because it not come again
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/splash_pic.jpg',
            fit: BoxFit.cover,
            height: height * .5,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.anton(
                letterSpacing: .6, color: Colors.grey.shade700),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          )
        ],
      ),
    );
  }
}
