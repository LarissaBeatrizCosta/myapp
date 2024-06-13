import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// Classe que conecta com a API do CNPJ
class CnpjController with ChangeNotifier {
  String _validationMessage = '';

/// Retorna validação cnpj
  String get validationMessage => _validationMessage;

  /// Faz a validação do CNPJ
  Future<void> validateCnpj(String cnpj) async {
    try {
      final response = await http.get(Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$cnpj'));

      if (response.statusCode == 200) {
        _validationMessage = 'CNPJ válido: ${json.decode(response.body)}';
      } else if (response.statusCode == 404) {
        _validationMessage = 'CNPJ não encontrado na API Brasil API';
      } else {
        _validationMessage = 'Não foi possível encontrar o CNPJ';
      }
    } catch (e) {
      _validationMessage = 'Erro: $e';
    }

    notifyListeners();
  }
}
