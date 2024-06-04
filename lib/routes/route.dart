import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../views/homeView.dart';

class Routes {
  static Route<dynamic> createRoutes(RouteSettings route) {
    switch (route.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Text("Pagina não encontrada!"),
          ),
        );
    }
  }
}
