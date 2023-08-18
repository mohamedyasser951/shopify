import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/home/presentation/pages/card_page.dart';
import 'package:commerceapp/features/home/presentation/pages/category_page.dart';
import 'package:commerceapp/features/home/presentation/pages/favorite_page.dart';
import 'package:commerceapp/features/home/presentation/pages/home_page.dart';
import 'package:commerceapp/features/home/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  List<String> titles = [
    "Home",
    "Categories",
    "Card",
    "Favorites",
    "My profile"
  ];
  List<Widget> screens = const [
    HomePage(),
    CategoryPage(),
    CardPage(),
    FavoritePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            bottomNavBarItem(icon: ImagesPath.home, label: "home"),
            bottomNavBarItem(icon: ImagesPath.shop, label: "shop"),
            bottomNavBarItem(icon: ImagesPath.card, label: "card"),
            bottomNavBarItem(icon: ImagesPath.favorite, label: "favorite"),
            bottomNavBarItem(icon: ImagesPath.profile, label: "profile"),
          ]),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(
        {required String label, required String icon}) =>
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
      ),
      activeIcon: SvgPicture.asset(
        "assets/svg/icons/active_$label.svg",
      ),
      label: label,
    );
