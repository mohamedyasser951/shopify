import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/home/presentation/pages/category_page.dart';
import 'package:commerceapp/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;
  List<Widget> screens = const [
    HomePage(),
    CategoryPage(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            bottomNavBarItem(icon: ImagesPath.home, label: "Home"),
            bottomNavBarItem(icon: ImagesPath.shop, label: "Shop"),
            bottomNavBarItem(icon: ImagesPath.favorite, label: "Favorite"),
            bottomNavBarItem(icon: ImagesPath.profile, label: "Profile"),
          ]),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(
        {required String label, required String icon}) =>
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: AppColors.grayColor,
      ),
      activeIcon: SvgPicture.asset(
        icon,
        color: AppColors.primaryColor,
      ),
      label: label,
    );
