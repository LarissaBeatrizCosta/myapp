// ignore_for_file: avoid_classes_with_only_static_members, João ajudou

import 'package:flutter/material.dart';
import '../views/customers_view.dart';
import '../views/home_view.dart';
import '../views/register_customer_view.dart';
import '../views/register_manager_view.dart';
import '../views/settings_view.dart';

/// Gerenciamento de rotas
class Routes {
  ///Crias as rotas
  static Route<dynamic> createRoutes(RouteSettings route) {
    switch (route.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsView());

      case '/register_customer':
        return MaterialPageRoute(builder: (_) => RegisterCustomer());

      case '/customers_view':
        return MaterialPageRoute(builder: (_) => const CustomersView());
      
      case '/register_manager':
        return MaterialPageRoute(builder: (_) =>  RegisterManagerView());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text('Pagina não encontrada!'),
          ),
        );
    }
  }
}
