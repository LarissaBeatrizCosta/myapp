import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/brand_vehicles_model.dart';
import '../models/model_vehicles_model.dart';

///Classe que conecta com a API da Fipe
class FipeController extends ChangeNotifier {
  ///Lista de tipos de veiculos
  List<String> typesVehicles = ['cars', 'motorcycles', 'trucks'];

  ///Tipo de veiculos selecionado
  String? typeSelected;

  ///Lista de marcas da API da Fipe
  List<BrandVehiclesModel> brandVehicles = [];

  ///Lista de modelos da API da Fipe
  List<ModelVehiclesModel> modelVehicles = [];

  ///Marca selecionada
  BrandVehiclesModel? brandSelected;

  ///Modelo Selecionado
  ModelVehiclesModel? modelSelected;

  ///Mensagem de validação
  String validationMessage = '';

  ///Busca marcas da API da Fipe
  Future<void> getBrandVehicles() async {
    try {
      if (typeSelected != null && typeSelected != '') {
        brandSelected = null;
        brandVehicles = [];

        final response = await http.get(
          Uri.parse(
              'https://fipe.parallelum.com.br/api/v2/$typeSelected/brands'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          for (final brand in jsonData) {
            brandVehicles.add(BrandVehiclesModel.fromMapBrandVehicles(brand));
          }
          notifyListeners();
        } else if (response.statusCode == 404) {
          validationMessage = 'Erro ao buscar a marca';
        } else if (response.statusCode == 500) {
          validationMessage = 'Erro interno da api';
        }
      }
    } catch (e) {
      validationMessage = 'Erro: $e';
    }
    notifyListeners();
  }

  ///Busca modelos da API  da Fipe
  Future<void> getModelVehicles() async {
    try {
      if (brandSelected != null) {
        modelSelected = null;
        modelVehicles = [];

        final response = await http.get(
          Uri.parse(
              'https://fipe.parallelum.com.br/api/v2/$typeSelected/brands/'
              '${brandSelected!.id}/models'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          for (final model in jsonData) {
            modelVehicles.add(
              ModelVehiclesModel.fromMapModelVehicles(model),
            );
          }
          notifyListeners();
        } else if (response.statusCode == 404) {
          validationMessage = 'Erro ao buscar a modelo';
        } else if (response.statusCode == 500) {
          validationMessage = 'Erro interno da api';
        }
      }
    } catch (e) {
      validationMessage = 'Erro: $e';
    }
    notifyListeners();
  }
}
