// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:tasks_collector/resources/core/sizing/size_config.dart';
// import 'package:tasks_collector/resources/features/statistics/presentation/pages/statistics.dart';
// import 'package:tasks_collector/resources/features/tasks/presentation/pages/tasks.dart';
// import 'package:tasks_collector/resources/features/user_information/presentation/pages/settings.dart';

// @RoutePage()
// class AppPage extends StatelessWidget {
//   AppPage({super.key});

//   final PageController _pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode =
//     Theme.of(context).brightness == Brightness.dark ? true : false;
//     return BlocProvider<NavigationCubit>(
//       create: (BuildContext context) => NavigationCubit(),
//       child: SafeArea(
//         child: Scaffold(
//           body: BlocBuilder<NavigationCubit, int>(
//             builder: (context, currentIndex) {
//               return PageView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   context.read<NavigationCubit>().changePage(index);
//                 },
//                 children: [
//                   TasksPage(),
//                   StatisticsPage(),
//                   SettingsPage(),
//                 ],
//               );
//             },
//           ),
//           bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
//             builder: (context, currentIndex) {
//               return BottomNavigationBar(
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 backgroundColor: Theme.of(context).colorScheme.surface,
//                 onTap: (index) {
//                   _pageController.animateToPage(
//                     index,
//                     duration: const Duration(milliseconds: 1),
//                     curve: Curves.easeInOut,
//                   );
//                   context.read<NavigationCubit>().changePage(index);
//                 },
//                 currentIndex: currentIndex,
//                 items: [
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Iconsax.home,
//                       size: 6.w,
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     ),
//                     activeIcon: Icon(
//                       Iconsax.home_15,
//                       size: 6.w,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Iconsax.graph,
//                       size: 6.w,
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     ),
//                     activeIcon: Icon(
//                       Iconsax.graph5,
//                       size: 6.w,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     label: 'Statistics',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(
//                       isDarkMode
//                           ? 'assets/images/dark_settings.svg'
//                           : 'assets/images/light_settings.svg',
//                       height: 6.w,
//                       width: 6.w,
//                     ),
//                     activeIcon: SvgPicture.asset(
//                       'assets/images/selected_settings.svg',
//                       height: 6.w,
//                       width: 6.w,
//                     ),
//                     label: 'Settings',
//                   ),
//                 ],
//                 selectedLabelStyle: GoogleFonts.cairo(
//                   color: Theme.of(context).colorScheme.primary,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 unselectedLabelStyle: GoogleFonts.cairo(
//                   color: Theme.of(context).colorScheme.primary,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 selectedItemColor: Theme.of(context).colorScheme.primary,
//                 unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NavigationCubit extends Cubit<int> {
//   NavigationCubit() : super(0); // Default to the first tab (index 0)

//   // Method to change the page index
//   void changePage(int index) {
//     emit(index);
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasks_collector/resources/core/routing/routes.gr.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';

import '../../utils/common_functions.dart';

@RoutePage()
class AppPage extends StatelessWidget {
  AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);

    return AutoTabsRouter(
      routes: [
        TasksNavigatorRoute(),
        StatisticsNavigatorRoute(),
        SettingsNavigatorRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        if (tabsRouter.current.name == 'SettingsNavigatorRoute') {
          CommonFunctions().changeStatusBarColor(
            true,
            isDarkMode,
            context,
            null,
          );
        } else {
          CommonFunctions().changeStatusBarColor(
            false,
            isDarkMode,
            context,
            null,
          );
        }
        final shouldHideNavBar = [
          TaskDetailsRoute.name,
          AddTaskRoute.name,
          ImageViewerRoute.name,
          ProfileInformationRoute.name,
          MapRoute.name,
          SearchRoute.name,
        ].contains(tabsRouter.topRoute.name);

        return Scaffold(
          body: child,
          bottomNavigationBar: shouldHideNavBar
              ? null
              : BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  onTap: (index) {
                    tabsRouter.setActiveIndex(index);
                  },
                  currentIndex: tabsRouter.activeIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.home,
                        size: 6.w,
                        color: Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                      activeIcon: Icon(
                        Iconsax.home_15,
                        size: 6.w,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Iconsax.graph,
                        size: 6.w,
                        color: Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                      activeIcon: Icon(
                        Iconsax.graph5,
                        size: 6.w,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: 'Statistics',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        isDarkMode
                            ? 'assets/images/dark_settings.svg'
                            : 'assets/images/light_settings.svg',
                        height: 6.w,
                        width: 6.w,
                      ),
                      activeIcon: SvgPicture.asset(
                        'assets/images/selected_settings.svg',
                        height: 6.w,
                        width: 6.w,
                      ),
                      label: 'Settings',
                    ),
                  ],
                  selectedLabelStyle: GoogleFonts.cairo(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.normal,
                  ),
                  unselectedLabelStyle: GoogleFonts.cairo(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.normal,
                  ),
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
                ),
        );
      },
    );
  }
}
