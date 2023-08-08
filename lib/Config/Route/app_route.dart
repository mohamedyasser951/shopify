import 'package:commerceapp/features/Auth/presentation/pages/login_page.dart';
import 'package:commerceapp/main.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case "/home":
        return MaterialPageRoute(builder: (context) => const HomePage());

      // case "/sebha":
      //   return MaterialPageRoute(
      //     builder: (context) => const SebhaPage(),
      //   );
      // case "/qibla":
      //   return MaterialPageRoute(
      //     builder: (context) => const QiblaFinderScreen(),
      //   );
    }

    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("Not Found Page"),
      ),
    );
  }
}
