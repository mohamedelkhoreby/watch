import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch/app/app_prefs.dart';

import '../presentation/routes/route_manager.dart';
import 'dependency_injection.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: instance<AppPreferences>().getLocal(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          context.setLocale(snapshot.data!);
        }
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: const Locale("en"),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.onGenerateRoute,
          initialRoute: Routes.loginRoute,
        );
      },
    );
  }
}
