import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme.dart';
import 'routes/route.dart';
import 'views/homeView.dart';
import 'views/settingsView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeState(),
      child: Consumer<ThemeState>(builder: (context, state, _) {
        return MaterialApp(
          theme: state.themeLight ? ThemeData.light() : ThemeData.dark(),
          initialRoute: "/",
          onGenerateRoute: Routes.createRoutes,
          routes: {
            "/": (context) => HomeView(),
          },
        );
      }),
    );
  }
}
