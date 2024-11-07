import 'package:flutter/material.dart';

import '../presentation/routes/route_manager.dart';

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
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        initialRoute: Routes.loginRoute);
  }
}
