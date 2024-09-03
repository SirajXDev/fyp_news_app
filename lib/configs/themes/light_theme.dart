import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application_2/configs/color/color.dart';

import 'themes.dart';

ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      iconTheme: IconThemeData(
        color: Colors.black,
      )),
  cardColor: AppColors.greyRedLight,
  // switchTheme: SwitchThemeData(
  //   thumbColor: WidgetStateProperty.all(
  //     AppColors.blue,
  //   ),
  //   trackColor: WidgetStateProperty.all(AppColors.blue.withOpacity(0.5)),
  // ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteLight,
    selectedIconTheme: IconThemeData(color: AppColors.black),
    unselectedIconTheme: IconThemeData(
      color: AppColors.greyLight,
    ),
  ),
  colorScheme: ThemeData.light().colorScheme.copyWith(
      secondary: AppColors.grey,
      primary: const Color(0xff0F0425),
      onPrimary: AppColors.blue,
      outline: const Color(0xfff0f0f0),
      onSurface: AppColors.blueLight,
      surface: const Color(0xffDCE8E8),
      primaryContainer: AppColors.orangeLight,
      onPrimaryContainer: const Color(0xffd8d8da)),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
  scaffoldBackgroundColor: Colors.white,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: Color(0xffECEAEA), color: ThemeConfig.primaryColor),
  primaryColor: ThemeConfig.primaryColor,
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.grey[200], // Change the background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Add rounded corners
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateColor.resolveWith(
      (states) => Colors.black.withOpacity(.4),
    ),
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
        titleMedium: GoogleFonts.poppins(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        titleSmall: GoogleFonts.poppins(
            color: Colors.black.withOpacity(.5),
            fontSize: 12,
            fontWeight: FontWeight.w500),
        displayLarge: GoogleFonts.poppins(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        displayMedium: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: ThemeConfig.textColor6B698E,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        displaySmall: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: ThemeConfig.textColorBCBFC2,
          fontSize: 16,
        ),
      ),
);
