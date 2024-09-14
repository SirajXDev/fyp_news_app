import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo_imp.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';
import 'package:news_application_2/repository/categ/categ_news_repo_imp.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo_imp.dart';
import 'package:news_application_2/repository/search/search_news_repo.dart';
import 'package:news_application_2/repository/search/search_news_repo_imp.dart';
import 'package:news_application_2/services/hive/book_mark_hive/hive_helper.dart';
import 'package:news_application_2/state_mgt/bloc/bloc/bookmark_bloc.dart';
import 'package:news_application_2/state_mgt/cubit/theme_cubit.dart';
import 'package:news_application_2/configs/routes/routes.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/configs/themes/themes.dart';
import 'package:news_application_2/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.initHiveDB(); // Initialize Hive

  await AdaptiveTheme.getThemeMode();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    if (kDebugMode) {
      print('Error loading .env file: $e');
    }
    // You can also set default values for your environment variables here
  }

  servicesLocator(); // Initializing service locator for dependency injection

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocProvider(
        create: (context) =>
            BookmarkBloc(baseBookMarkRepo: getIt<BaseBookMarkRepo>()),
        child: const MyApp(),
      ),
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
        // home: const ProfileView(),
      ),
    );
  }
}

// Function for initializing service locator
void servicesLocator() {
  getIt.registerLazySingleton<HeadlinesNewsRepo>(() => HeadlinesNewsRepoImp());
  getIt.registerLazySingleton<CategNewsRepo>(() => CategNewsRepoImp());
  getIt.registerLazySingleton<SearchNewsRepo>(() => SearchNewsRepoImp());
  getIt.registerLazySingleton<BaseBookMarkRepo>(() => BookMarkRepoImp());
}


//flutter pub run build_runner build --delete-conflicting-outputs