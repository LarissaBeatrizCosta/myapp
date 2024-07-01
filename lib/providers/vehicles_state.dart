import 'package:flutter/material.dart';

import '../controllers/database.dart';
import '../models/vehicles_model.dart';

///Gerencia veículos
class VehiclesState extends ChangeNotifier {
  ///Lista de veículos
  final vehicles = <VehiclesModel>[];

  ///Tabela de veículos
  final tableVehicles = TableVehicles();

  ///Inicializa a lista dos veículos
  VehiclesState() {
    _initState();
    notifyListeners();
  }

  void _initState() async {
    vehicles
      ..clear()
      ..addAll(
        await tableVehicles.getVehicle(),
      );
    notifyListeners();
  }

  ///Deleta veículos
  void deleteVehicles(VehiclesModel plate) async {
    await tableVehicles.deleteVehicle(plate);
    vehicles.remove(plate);
    notifyListeners();
  }

  ///Atualiza os veículos
  void updateVehicles(VehiclesModel plate) async {
    await tableVehicles.updateVehicle(plate);
    notifyListeners();
  }
}
