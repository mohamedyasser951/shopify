part of "main.dart";

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final QuickActions quickActions = QuickActions();
  @override
  void initState() {
    initializeQuickAction();
    super.initState();
  }

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
              create: (context) => di.sl<CategoriesDetailsCubit>(),
            ),
            BlocProvider(
              create: (context) => di.sl<BottomNavCubit>(),
            ),
          ],
          child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
            return MaterialApp(
              // locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
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

  void initializeQuickAction() {
    quickActions.initialize((String shortcutHandler) {
      switch (shortcutHandler) {
        case "1":
          Navigator.pushNamed(context, "/home");
          break;
        case "2":
          Navigator.pushNamed(context, "/ordersPage");
          break;
      }
    });
    quickActions.setShortcutItems([
      ShortcutItem(type: "1", localizedTitle: "Home", icon: "one"),
      ShortcutItem(type: "2", localizedTitle: "Orders", icon: "Two"),
    ]);
  }
}
