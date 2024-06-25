import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/brand_vehicles.dart';
import '../models/model_vehicles.dart';

///Classe que conecta com a API da Fipe
class FipeController extends ChangeNotifier {
  ///Lista de tipos de veiculos
  final List<String> typesVehicles = ['Carros', 'Motos', 'Caminhões'];

  ///Tipo de veiculos selecionado
  String? typeSelected;

  ///Lista de marcas da API da Fipe
  final List<BrandVehiclesModel> brandVehicles = [];

  ///Lista de modelos da API da Fipe
  final List<ModelVehiclesModel> modelVehicles = [];

  ///Marca selecionada
  BrandVehiclesModel? brandSelected;

  ///Modelo Selecionado
  ModelVehiclesModel? modelSelected;
  String _validationMessage = '';

  ///Busca marcas da API da Fipe
  Future<void> getBrandVehicles() async {
    try {
      if (typeSelected != null || typeSelected != '') {
        brandSelected = null;

        final response = await http.get(
          Uri.parse(
              'https://fipe.parallelum.com.br/api/v2/$typeSelected/brands'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          for (final brand in jsonData) {
            _brandVehicles.add(BrandVehiclesModel.fromMapBrandVehicles(brand));
          }
          // notifyListeners();
        } else if (response.statusCode == 404) {
          _validationMessage = 'Erro ao buscar a marca';
        } else if (response.statusCode == 500) {
          _validationMessage = 'Erro interno da api';
        }
      }
    } catch (e) {
      _validationMessage = 'Erro: $e';
    }
    notifyListeners();
  }

  ///Busca modelos da API  da Fipe
  Future<void> getModelVehicles() async {
    try {
      if (typeSelected != null || typeSelected != '') {
        modelSelected = null;

        final response = await http.get(
          Uri.parse(
              'https://fipe.parallelum.com.br/api/v2/$typeSelected/brands/'
              '${brandSelected!.id}/models'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          for (final model in jsonData) {
            _modelVehicles.add(
              ModelVehiclesModel.fromMapModelVehicles(model),
            );
          }
        } else if (response.statusCode == 404) {
          _validationMessage = 'Erro ao buscar a modelo';
        } else if (response.statusCode == 500) {
          _validationMessage = 'Erro interno da api';
        }
      }
    } catch (e) {
      _validationMessage = 'Erro: $e';
    }
    notifyListeners();
  }
}
