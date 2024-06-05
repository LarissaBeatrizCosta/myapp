import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../views/homeView.dart';
import '../views/settingsView.dart';

class Routes {
  static Route<dynamic> createRoutes(RouteSettings route) {
    switch (route.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeView());

      case "/settings":
        return MaterialPageRoute(builder: (_) => SettingsView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Text("Pagina não encontrada!"),
          ),
        );
    }
  }
}
