import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// Classe que conecta com a API do CNPJ
class CnpjController with ChangeNotifier {
  String _validationMessage = '';
  String _returnedName = '';
  late bool _validateCNPJ;
  late bool _validateName;

  /// Retorna a mensagem da validação
  String get validationMessage => _validationMessage;

  /// Retorna a validação
  bool get validateCNPJ => _validateCNPJ;

  /// Retorna a validação
  bool get validateName => _validateName;

  /// Retorna a resposta da api do cnpj
  Future<void> validateCnpj(String cnpj, String name) async {
    try {
      final response = await http
          .get(Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$cnpj'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _returnedName = jsonData['nome_fantasia'];
        _validateCNPJ = true;

        if (_returnedName == name) {
          _validationMessage = 'CNPJ válido e nome correspondente';
          _validateName = true;
        } else {
          _validationMessage = 'CNPJ válido, mas nome não é correspondente';
          _validateName = false;
        }
      } else if (response.statusCode == 404) {
        _validationMessage = 'CNPJ não encontrado na API Brasil API';
        _validateCNPJ = false;
        _validateName = false;
      } else {
        _validationMessage = 'Não foi possível encontrar o CNPJ';
        _validateCNPJ = false;
        _validateName = false;
      }
    } catch (e) {
      _validationMessage = 'Erro: $e';
      _validateCNPJ = false;
      _validateName = false;
    }

    notifyListeners();
  }
}
