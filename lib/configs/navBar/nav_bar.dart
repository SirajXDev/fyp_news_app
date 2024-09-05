import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/navBar/nav_bar_controller.dart';
import 'package:news_application_2/configs/navBar/tabs.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: Scaffold(
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return IndexedStack(
              index: currentIndex,
              children: tabsViews,
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                context.read<NavigationCubit>().updateIndex(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  selectedIcon: Icon(Icons.home),
                ),
                NavigationDestination(
                  icon: Icon(CupertinoIcons.search_circle),
                  label: 'Search',
                  selectedIcon: Icon(CupertinoIcons.search_circle_fill),
                ),
                NavigationDestination(
                  icon: Icon(CupertinoIcons.bookmark),
                  label: 'BookMark',
                  selectedIcon: Icon(CupertinoIcons.bookmark_fill),
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                  selectedIcon: Icon(Icons.settings),
                ),
              ],
              animationDuration: const Duration(
                milliseconds: 500,
              ),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              surfaceTintColor: AppColors.whiteColor,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              indicatorColor: Theme.of(context).colorScheme.onSurface,
              height: context.mqh * .08,
              // indicatorColor: AppColors.blue,
              elevation: 0.0,
            );
          },
        ),
      ),
    );
  }
}
