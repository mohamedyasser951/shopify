import 'package:commerceapp/features/Auth/presentation/pages/login_page.dart';
import 'package:commerceapp/features/Auth/presentation/pages/register_page.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/pages/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (context) => const LoginPage(),
      //   );
      case "/":
        return MaterialPageRoute(
            builder: (context) =>
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return const AppLayout();
                }));

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
