import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// Classe que conecta com a API do CPF
class CpfController with ChangeNotifier {
  String _validationMessage = '';
  String _returnedName = '';
  late bool _validateCPF;
  late bool _validateName;

  /// Retorna a mensagem da validação
  String get validationMessage => _validationMessage;

  /// Retorna a validação
  bool get validateCPF => _validateCPF;

  /// Retorna a validação
  bool get validateName => _validateName;

  /// Retorna a resposta da api do cpf
  Future<void> validateCpf(String cpf, String name) async {
    try {
      final response = await http.get(Uri.parse(
          'https://apigateway.conectagov.estaleiro.serpro.gov.br/api-cpf-light/v2/consulta/cpf'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _returnedName = jsonData['Nome'];
        _validateCPF = true;

        if (_returnedName == name) {
          _validationMessage = 'CPF válido e nome correspondente';
          _validateName = true;
        } else {
          _validationMessage = 'CPF válido, mas nome não é correspondente';
          _validateName = false;
        }
      } else if (response.statusCode == 404) {
        _validationMessage = 'CPF não encontrado na API CPF Light';
        _validateCPF = false;
        _validateName = false;
      } else {
        _validationMessage = 'Não foi possível encontrar o CPF';
        _validateCPF = false;
        _validateName = false;
      }
    } catch (e) {
      _validationMessage = 'Erro: $e';
      _validateCPF = false;
      _validateName = false;
    }

    notifyListeners();
  }
}
