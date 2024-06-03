import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Escolha o idioma da sua preferência"),
              ],
            ),
          ),
        );
      }),
    );
  }
}
