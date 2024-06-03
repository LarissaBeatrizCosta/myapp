import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _themeKey = 'themeLight';

class _ThemeState extends ChangeNotifier {
  _ThemeState() {
    _initState();
  }

  late final SharedPreferences _sharedPreferences;
  var _themeLight = true;
  bool get themeLight => _themeLight;

  Future<void> _initState() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _themeLight = _sharedPreferences.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  void changeTheme() {
    _themeLight = !_themeLight;
    _sharedPreferences.setBool(_themeKey, _themeLight);
    notifyListeners();
  }
}
