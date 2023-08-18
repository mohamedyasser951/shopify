import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/Auth/presentation/pages/login_page.dart';
import 'package:commerceapp/features/Auth/presentation/pages/register_page.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/pages/app_layout.dart';
import 'package:commerceapp/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    Widget startWidget = const AppLayout();

    if ( Hive.box(AppStrings.settingsBox).get("Token") != null) {
      startWidget = const AppLayout();
    }

    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (context) =>
                BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  return startWidget;
                }));
      case "/home":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<HomeBloc>(
                create: (context) => sl<HomeBloc>()
                  ..add(GetHomeDataEvent())
                  ..add(GetCategoriesEvent())..add(GetFavoritesEvent()),
                child: const AppLayout()));

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
