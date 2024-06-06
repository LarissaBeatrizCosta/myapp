import 'package:flutter/material.dart';

import '../views/home_view.dart';
import '../views/settings_view.dart';

/// Gerenciamento de rotas
class  Routes {
  ///Crias as rotas
  static Route<dynamic> createRoutes(RouteSettings route) {
    switch (route.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsView());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text('Pagina não encontrada!'),
          ),
        );
    }
  }
}
