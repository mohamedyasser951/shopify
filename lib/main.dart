import 'package:commerceapp/Config/Route/app_route.dart';
import 'package:commerceapp/Config/Theme/theme.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'service_locator.dart' as di;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  await Hive.openBox(AppStrings.settingsBox);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => di.sl<HomeBloc>()
              ..add(GetHomeDataEvent())
              ..add(GetCategoriesEvent()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: "/",
          // home: LoginPage(),
        ));
  }
}
