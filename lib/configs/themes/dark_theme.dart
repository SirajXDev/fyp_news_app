import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application_2/configs/color/color.dart';

import 'themes.dart';

ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: AppBarTheme(
        toolbarTextStyle: ThemeData.light().textTheme.displayMedium!.copyWith(
            fontFamily: ThemeConfig.pangramRegular,
            color: AppColors.black,
            fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        )),
    cardTheme: const CardTheme(
      color: AppColors.whiteColor,
    ),
    cardColor: AppColors.whiteColor,
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    textTheme: ThemeData.dark().textTheme.copyWith(
          titleMedium: GoogleFonts.roboto(
            color: Colors.white,
          ),
          titleSmall: GoogleFonts.roboto(
            color: Colors.white.withOpacity(.5),
          ),
          displayLarge: GoogleFonts.roboto(
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: GoogleFonts.roboto(
            color: ThemeConfig.textColor6B698E,
          ),
          displaySmall: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.roboto(
            color: ThemeConfig.textColorBCBFC2,
          ),
        ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith(
          (states) => Colors.white.withOpacity(.3)),
    ),
    // switchTheme: SwitchThemeData(
    //   thumbColor: WidgetStateProperty.all(
    //     Colors.indigo,
    //   ),
    //   trackColor: WidgetStateProperty.all(Colors.indigo.withOpacity(0.5)),
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      selectedIconTheme: IconThemeData(color: AppColors.whiteColor),
      unselectedIconTheme: IconThemeData(
        color: AppColors.grey,
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
        secondary: AppColors.grey,
        primary: AppColors.whiteColor,
        onPrimary: Colors.indigo,
        outline: Colors.black,
        onSurface: Colors.indigo.shade400,
        brightness: Brightness.dark,
        surface: const Color(0xff202934),
        primaryContainer: AppColors.green,
        onPrimaryContainer: const Color(0xff5a5f62)),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: Colors.white, color: ThemeConfig.primaryColor),
    primaryColor: ThemeConfig.primaryColor,
    scaffoldBackgroundColor: ThemeConfig.darkBackColor);
