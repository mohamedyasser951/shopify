import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/Auth/presentation/pages/login_page.dart';
import 'package:commerceapp/features/Auth/presentation/pages/register_page.dart';
import 'package:commerceapp/features/home/presentation/pages/Categories/category_details_page.dart';
import 'package:commerceapp/features/home/presentation/pages/app_layout.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/add_or_update_address_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/addresses_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/bloc/orders_bloc.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/pages/order_details_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/pages/orders_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Settings/settings_page.dart';
import 'package:commerceapp/features/settings/presentation/pages/Settings/update_profile_page.dart';
import 'package:commerceapp/on_boarding.dart';
import 'package:commerceapp/service_locator.dart';
import 'package:commerceapp/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    Widget startWidget;
    var settingBox = Hive.box(AppStrings.settingsBox);
    
    if (settingBox.get("onBoarding") == null) {
      startWidget = const OnBoardingPage();
    } else if (settingBox.get("Token") != null) {
      startWidget =const AppLayout();
    } else {
      startWidget = const LoginPage();
    }

    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (context) => SplashPage(startWidget: startWidget));

      case "/home":
        return MaterialPageRoute(builder: (_) =>const AppLayout());
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
          builder: (context) => SettingsPage(),
        );
      case "/ordersPage":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<OrdersBloc>()..add(GetAllOrdersEvent()),
            child: const OrdersPage(),
          ),
        );
      case "/orderDetailsPage":
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: sl<OrdersBloc>(),
            child: OrderDetailsPage(orderId: routeSettings.arguments as int),
          ),
        );
      case "/getCategoryDetails":
        return MaterialPageRoute(
          builder: (context) => CategoryDetailsPage(
              categoryName: routeSettings.arguments as String),
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
          builder: (context) => const AddOrUpdateAddressesPage(),
        );
    }

    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("Not Found Page"),
      ),
    );
  }
}
