import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:news_application_2/configs/routes/navBar/nav_bar.dart';
import 'package:news_application_2/repository/admin/admin_crud_repo_imp.dart';
import 'package:news_application_2/repository/admin/base_admin_crud_repo.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo.dart';
import 'package:news_application_2/repository/book_mark/book_mark_repo_imp.dart';
import 'package:news_application_2/repository/categ/categ_news_repo.dart';
import 'package:news_application_2/repository/categ/categ_news_repo_imp.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo.dart';
import 'package:news_application_2/repository/headlines/headlines_news_repo_imp.dart';
import 'package:news_application_2/repository/profile/base_profile_repo.dart';
import 'package:news_application_2/repository/search/search_news_repo.dart';
import 'package:news_application_2/repository/search/search_news_repo_imp.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin_dashboard_view.dart';
import 'package:news_application_2/services/local/hive/book_mark_hive/hive_helper.dart';
import 'package:news_application_2/state_mgt/bloc/admin/bloc/manage_news_admin_bloc.dart';
import 'package:news_application_2/state_mgt/bloc/profile/profile_bloc.dart';
import 'package:news_application_2/state_mgt/bloc/bookmark/bookmark_bloc.dart';
import 'package:news_application_2/state_mgt/cubit/theme_cubit.dart';
import 'package:news_application_2/configs/routes/routes.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/configs/themes/themes.dart';
import 'package:news_application_2/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:news_application_2/utils/helper_methods/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/profile/profile_repo_imp.dart';

// GetIt is a package used for service locator or to manage dependency injection
final GetIt getIt = GetIt.instance;

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
      debugPrint('Error loading .env file: $e');
    }
    // You can also set default values for your environment variables here
  }

  await servicesLocator(); // Initializing service locator for dependency injection

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
            create: (context) =>
                BookmarkBloc(baseBookMarkRepo: getIt<BaseBookMarkRepo>())),
        BlocProvider(
            create: (context) => ProfileBloc(getIt<BaseProfileRepository>())),
        BlocProvider(
            create: (context) =>
                ManageNewsAdminBloc(getIt<BaseAdminCRUdRepo>())),
      ],
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
        // home: const ProfileView(),
      ),
    );
  }
}

// Function for initializing service locator
Future<void> servicesLocator() async {
  debugPrint('Service locator initialized');

  debugPrint('Registering HeadlinesNewsRepo');
  getIt.registerLazySingleton<HeadlinesNewsRepo>(() => HeadlinesNewsRepoImp());

  debugPrint('Registering CategNewsRepo');
  getIt.registerLazySingleton<CategNewsRepo>(() => CategNewsRepoImp());

  debugPrint('Registering SearchNewsRepo');
  getIt.registerLazySingleton<SearchNewsRepo>(() => SearchNewsRepoImp());

  debugPrint('Registering BaseBookMarkRepo');
  getIt.registerLazySingleton<BaseBookMarkRepo>(() => BookMarkRepoImp());

  debugPrint('Registering BaseProfileRepository');
  getIt.registerLazySingleton<BaseProfileRepository>(
      () => ProfileRepositoryImpl());

  debugPrint('  - BaseAdminCRUdRepo (AdminCrudRepoImp)');
  getIt.registerLazySingleton<BaseAdminCRUdRepo>(() => AdminCrudRepoImp());

  debugPrint('  - Register SharedPreferences');
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  debugPrint('  - Now SharedPreferences is initialized');
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper(getIt<SharedPreferences>()));
}

//flutter pub run build_runner build --delete-conflicting-outputs

class RoleBasedNavigation extends StatelessWidget {
  const RoleBasedNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Remove setState() and duplicate navigation
        FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String? storedRole = snapshot.data!.getString('role');
          if (storedRole == 'admin') {
            return const AdminDashBoardView();
          } else if (storedRole == 'user') {
            return const NavBar();
          } else {
            return const Center(child: Text('Role is not defined'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
