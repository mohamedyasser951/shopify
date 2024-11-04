import 'package:commerceapp/Config/Route/app_route.dart';
import 'package:commerceapp/Config/Theme/theme.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/bloc_observer.dart';
import 'package:commerceapp/features/categories/presentation/cubit/categories_details_cubit.dart';
import 'package:commerceapp/features/layout/cubits/bottom_cubit/bottom_nav_cubit.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_actions/quick_actions.dart';
import 'service_locator.dart' as di;
// import 'package:flutter_stripe/flutter_stripe.dart';
part  "app.dart";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  // Stripe.publishableKey = StripApiKeys.publishableKey;
  var box = await Hive.openBox(AppStrings.settingsBox);
  TOKEN = box.get("Token");
  print(TOKEN);
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => App(), // Wrap your app
    ),
  );
}
