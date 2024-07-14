import 'package:flutter/material.dart';

///Classe responsável por gerenciar o idioma
class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('pt', '');

  ///Retorna o idioma atual
  Locale get locale => _locale;

  ///Troca o idioma
  void changeLanguage(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
