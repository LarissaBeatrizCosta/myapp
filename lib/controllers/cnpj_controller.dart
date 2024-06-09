import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cnpj_model.dart';

/// Class que conecta com a api do cnpj
class CnpjController {
  ///Conecta e retorna carregamento da api do cnpj
  Future<CnpjModel> getApiCnpj(String cnpj) async {
    final response =
        await http.get(Uri.parse('https://brasilapi.com.br/api/cnpj/v1/$cnpj'));

    if (response.statusCode == 200) {
      return CnpjModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro no carregamento da API');
    }
  }

///Valida os dados do cnpj
  void validateCnpj(String cnpj, String nome, String telefone, String estado,
      String cidade) async {
    try {
      final cnpjModel = await getApiCnpj(cnpj);
    } catch (e) {
      throw Exception('Erro nos dados buscados');
    }
  }
}
