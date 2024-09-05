import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the Cubit
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void toggleTheme(BuildContext context) {
    emit(!state);
    if (state) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }
}
