import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/Auth/presentation/pages/login_page.dart';
import 'package:commerceapp/features/Auth/presentation/pages/register_page.dart';
import 'package:commerceapp/features/home/presentation/pages/app_layout.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/add_or_update_address_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/addresses_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/bloc/orders_bloc.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/pages/orders_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Settings/settings_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Settings/update_profile_page.dart';
import 'package:commerceapp/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    Widget startWidget = const LoginPage();

    if (Hive.box(AppStrings.settingsBox).get("Token") != null) {
      startWidget = const AppLayout();
    }

    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => startWidget);

      case "/home":
        return MaterialPageRoute(builder: (_) => const AppLayout());
      case "/login":
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case "/register":
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case "/settings":
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        );
      case "/ordersPage":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<OrdersBloc>()..add(GetAllOrdersEvent()),
            child: const OrdersPage(),
          ),
        );
      case "/updateProfile":
        return MaterialPageRoute(
          builder: (context) => const UpdateProfilePage(),
        );
      case "/adressesPage":
        return MaterialPageRoute(
          builder: (context) => const AdressesPage(),
        );
      case "/addOrUpdateAddressesPage":
        return MaterialPageRoute(
          builder: (context) => AddOrUpdateAddressesPage(),
        );
    }

    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("Not Found Page"),
      ),
    );
  }
}
