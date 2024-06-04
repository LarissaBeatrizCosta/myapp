import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/theme.dart';

//teste
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeState(),
      child: Consumer<ThemeState>(builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                //todo: função que volta para home
              },
            ),
            backgroundColor: Color.fromARGB(255, 0, 29, 61),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Escolha o tema da sua preferência"),
                SizedBox(height: 10),
                IconButton(
                  onPressed: state.changeTheme,
                  icon: Icon(
                    state.themeLight ? Icons.light_mode : Icons.dark_mode,
                    color: Color.fromRGBO(255, 195, 0, 1),
                  ),
                ),
                SizedBox(height: 70),
                Text("Escolha o idioma da sua preferência"),
              ],
            ),
          ),
        );
      }),
    );
  }
}
