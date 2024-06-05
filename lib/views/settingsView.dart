import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/theme.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, "/"),
        ),
        backgroundColor: Color.fromARGB(255, 0, 29, 61),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Escolha o tema da sua preferência",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: state.changeTheme,
                  icon: Icon(
                    state.themeLight ? Icons.light_mode : Icons.dark_mode,
                    color: Color.fromRGBO(255, 195, 0, 1),
                  ),
                ),
                IconButton(
                  onPressed: () => state.changeThemeSystem(context),
                  icon: Icon(
                    Icons.android,
                    color: Color.fromRGBO(0, 53, 102, 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Text(
              "Escolha o idioma da sua preferência",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Row(
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
