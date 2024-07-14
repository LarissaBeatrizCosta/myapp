import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/language_state.dart';
import '../providers/theme.dart';

/// Tela de configurações
class SettingsView extends StatelessWidget {
  /// Construtor da classe
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.chooseTheme,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: state.changeTheme,
                  icon: Icon(
                    state.themeLight ? Icons.light_mode : Icons.dark_mode,
                    color: const Color.fromRGBO(255, 195, 0, 1),
                  ),
                ),
                IconButton(
                  onPressed: () => state.changeThemeSystem(context),
                  icon: Icon(
                    Icons.android,
                    color: state.themeLight
                        ? const Color.fromRGBO(0, 53, 102, 1)
                        : Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Text(
              AppLocalizations.of(context)!.chooseLanguage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeLanguage(
                    context,
                    const Locale('pt', ''),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.portuguese,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 195, 0, 1),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => changeLanguage(
                    context,
                    const Locale('en', ''),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.english,
                    style: TextStyle(
                      color: state.themeLight
                          ? const Color.fromRGBO(0, 53, 102, 1)
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

////Troca o idioma
  void changeLanguage(BuildContext context, Locale locale) {
    Provider.of<LanguageProvider>(context, listen: false)
        .changeLanguage(locale);
  }
}
