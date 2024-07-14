import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/language_state.dart';
import 'providers/theme.dart';
import 'routes/route.dart';
import 'views/home_view.dart';

/// Função principal que chama a inicialização do app
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

/// Classe responsável por inicializar o app
class MyApp extends StatelessWidget {
  /// Construtor da classe MyApp
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeDark = ThemeData.dark();
    final themeLight = ThemeData.light();
    final languageProvider = Provider.of<LanguageProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => ThemeState(),
      child: Consumer<ThemeState>(
        builder: (context, state, _) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            themeMode: state.themeLight ? ThemeMode.light : ThemeMode.dark,
            darkTheme: themeDark.copyWith(
              appBarTheme: themeLight.appBarTheme.copyWith(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(0, 29, 61, 1),
              ),
            ),
            theme: themeLight.copyWith(
              appBarTheme: themeLight.appBarTheme.copyWith(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(0, 29, 61, 1),
              ),
            ),
            locale: languageProvider.locale,
            initialRoute: '/',
            onGenerateRoute: Routes.createRoutes,
            routes: {
              '/': (context) => const HomeView(),
            },
          );
        },
      ),
    );
  }
}
