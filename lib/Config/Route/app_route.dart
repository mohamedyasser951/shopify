import 'package:commerceapp/features/Auth/presentation/pages/login_page.dart';
import 'package:commerceapp/features/Auth/presentation/pages/register_page.dart';
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

      case "/login":
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case "/register":
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );
    }

    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("Not Found Page"),
      ),
    );
  }
}
