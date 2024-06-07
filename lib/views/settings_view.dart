import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme.dart';

/// Tela de configurações
class SettingsView extends StatelessWidget {
  /// Construtor da classe
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 29, 61),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha o tema da sua preferência',
              style: TextStyle(
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
            const Text(
              'Escolha o idioma da sua preferência',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Português',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 195, 0, 1)
                       
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Inglês',
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
}

//teste commit
