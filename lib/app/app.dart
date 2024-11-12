import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch/app/app_prefs.dart';

import '../presentation/routes/route_manager.dart';
import 'dependency_injection.dart';

class MainApp extends StatefulWidget {
  //name const
  const MainApp.internal({super.key});

  final int appState = 0;
  //singleton or single instance
  static const MainApp _instance = MainApp.internal();
  //factory
  factory MainApp() => _instance;
  @override
  AppState createState() => AppState();
}

class AppState extends State<MainApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        initialRoute: Routes.loginRoute);
  }
}
