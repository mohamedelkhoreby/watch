import 'package:flutter/material.dart';

import '../../app/dependency_injection.dart';
import '../Auth/view/login_view.dart';
import '../main/view/main_view.dart';
import '../resources/string_manager.dart';

class Routes {
  static const String loginRoute = "/";
  static const String mainRoute = "/main";
}

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.data),
          ),
          body: const Center(child: Text(AppStrings.data)));
      },
    );
  }
}
