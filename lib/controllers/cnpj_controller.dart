import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// Class que conecta com a api do cnpj
class CnpjController with ChangeNotifier {
  ///Faz a validação do cnpj
  Future<void> validateCnpj(String cnpj) async {
    var response =
        await http.get(Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$cnpj'));
    var data = json.decode(response.body);
    // print('JSON Data: $data'); // Print the JSON data
    return data;
  }
}
