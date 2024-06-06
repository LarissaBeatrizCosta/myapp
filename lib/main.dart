import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme.dart';
import 'routes/route.dart';
import 'views/home_view.dart';

/// Função principal que chama a inicialização do app
void main() {
  runApp(const MyApp());
}

/// Classe responsável por inicializar o app
class MyApp extends StatelessWidget {
  /// Construtor da classe MyApp
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeState(),
      child: Consumer<ThemeState>(builder: (context, state, _) {
        return MaterialApp(
          theme: state.themeLight ? ThemeData.light() : ThemeData.dark(),
          initialRoute: '/',
          onGenerateRoute: Routes.createRoutes,
          routes: {
            '/': (context) => const HomeView(),
          },
        );
      }),
    );
  }
}
