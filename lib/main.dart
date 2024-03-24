import 'package:commerceapp/Config/Route/app_route.dart';
import 'package:commerceapp/Config/Theme/theme.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/bloc_observer.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/home/PaymentService/strip_api_keys.dart';
import 'package:commerceapp/features/home/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'service_locator.dart' as di;
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  Stripe.publishableKey = StripApiKeys.publishableKey;
  var box = await Hive.openBox(AppStrings.settingsBox);
  TOKEN = box.get("Token");
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppStrings.settingsBox).listenable(),
      builder: (context, box, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => di.sl<HomeBloc>()),
            BlocProvider(
                create: (context) => di.sl<SettingsBloc>()
                  ..add(ChangeAppModeEvent(
                      modeFromCashe: box.get("darkMode", defaultValue: false)))
                  ..add(ChangeLanguageEvent(
                      lang: box.get("lang", defaultValue: "en")))),
            BlocProvider(
              create: (context) => di.sl<AuthBloc>(),
            ),
            BlocProvider(
              create: (context) => di.sl<CartBloc>(),
            ),
          ],
          child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale(BlocProvider.of<SettingsBloc>(context).appLang),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: BlocProvider.of<SettingsBloc>(context).isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              onGenerateRoute: AppRoute.onGenerateRoute,
              initialRoute: "/",
            );
          }),
        );
      },
    );
  }
}
