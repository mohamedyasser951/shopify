import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/home/presentation/pages/card_page.dart';
import 'package:commerceapp/features/home/presentation/pages/Categories/category_page.dart';
import 'package:commerceapp/features/home/presentation/pages/favorite_page.dart';
import 'package:commerceapp/features/home/presentation/pages/home_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/profile.dart';
import 'package:commerceapp/generated/l10n.dart';
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
    CardPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            bottomNavBarItem(
                icon: ImagesPath.home,
                activeIcon: ImagesPath.activeHome,
                label: S.of(context).home),
            bottomNavBarItem(
                icon: ImagesPath.shop,
                activeIcon: ImagesPath.activeShop,
                label: S.of(context).shop),
            bottomNavBarItem(
                icon: ImagesPath.card,
                activeIcon: ImagesPath.activeCard,
                label: S.of(context).card),
            bottomNavBarItem(
                icon: ImagesPath.favorite,
                activeIcon: ImagesPath.activeFavorite,
                label: S.of(context).favorites),
            bottomNavBarItem(
                icon: ImagesPath.profile,
                activeIcon: ImagesPath.activeProfile,
                label: S.of(context).profile),
          ]),
    );
  }
}

BottomNavigationBarItem bottomNavBarItem(
        {required String label,
        required String icon,
        required String activeIcon}) =>
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
      ),
      activeIcon: SvgPicture.asset(activeIcon),
      label: label,
    );
