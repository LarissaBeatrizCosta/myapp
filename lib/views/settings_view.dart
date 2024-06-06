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
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Escolha o tema da sua preferência',
              style: TextStyle(
                fontSize: 16,
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
                  icon: const Icon(
                    Icons.android,
                    color: Color.fromRGBO(0, 53, 102, 1),
                  ),
                ),
              ],
            ),
             const SizedBox(height: 60),
             const Text(
              'Escolha o idioma da sua preferência',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
             const SizedBox(height: 10),
             const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
// ElevatedButton(onPressed: () =>, child: Text("Portuguese"),),
// ElevatedButton(onPressed: () => , child: Text("English"),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//teste commit
