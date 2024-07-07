import 'package:flutter/material.dart';

import '../controllers/database.dart';
import '../models/rent_model.dart';

///Gerencia aluguéis
class RentState extends ChangeNotifier {
  ///Cliente selecionado
  String? customerSelected;

  ///Gerente selecionado
  String? managerSelected;

  ///Veículo selecionado
  String? vehicleSelected;

  ///Lista de aluguéis
  final rents = <RentVehicleModel>[];

  ///Tabela de aluguéis
  final tableRents = TableRents();

  ///Inicializa a lista dos aluguéis
  RentState() {
    _initState();
    notifyListeners();
  }

  void _initState() async {
    rents
      ..clear()
      ..addAll(
        await tableRents.getRents(),
      );
    notifyListeners();
  }

  ///Deleta aluguéis
  void deleteRents(RentVehicleModel id) async {
    await tableRents.deleteRents(id);
    rents.remove(id);
    notifyListeners();
  }

  ///Atualiza os aluguéis
  void updateRents(RentVehicleModel id) async {
    await tableRents.updateRents(id);
    notifyListeners();
  }
}
