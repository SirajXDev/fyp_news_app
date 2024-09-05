import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/bloc/cubit/theme_cubit.dart';
import 'package:news_application_2/configs/routes/routes.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/configs/themes/themes.dart';
import 'package:news_application_2/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdaptiveTheme.getThemeMode();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await dotenv.load(fileName: 'assets/.env');
  } catch (e) {
    print('Error loading .env file: $e');
    // You can also set default values for your environment variables here
  }

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'THE NEWS HEADLINES',
        // themeMode: ThemeMode.system,
        darkTheme: darkTheme,
        theme: theme,
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
        // home: const NavBar(),
      ),
    );
  }
}
