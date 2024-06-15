import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'themeLight';

/// Faz o gerenciamento do tema das telas
class ThemeState extends ChangeNotifier {
  /// Inicializa o tema das telas
  ThemeState() {
    _initState();
  }

  late final SharedPreferences _sharedPreferences;
  var _themeLight = true;

  /// Tema do tipo light
  bool get themeLight => _themeLight;

  Future<void> _initState() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _themeLight = _sharedPreferences.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  /// Faz a mudança do tema
  void changeTheme() {
    _themeLight = !_themeLight;
    _sharedPreferences.setBool(_themeKey, _themeLight);
    notifyListeners();
  }

  /// Reconhece o tema do sistema e faz a mudança
  void changeThemeSystem(BuildContext context) {
    var themeSystem = 
    MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    _themeLight = !themeSystem;
    _sharedPreferences.setBool(_themeKey, _themeLight);
    notifyListeners();
  }

  
}
