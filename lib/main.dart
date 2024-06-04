import 'package:flutter/material.dart';
import 'routes/route.dart';
import 'views/homeView.dart';
import 'views/settingsView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: Routes.createRoutes,
      routes: {
        "/": (context) => SettingsView(),
      },
    );
  }
}
