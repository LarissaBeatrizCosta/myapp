import 'package:flutter/material.dart';

import '../controllers/database.dart';
import '../models/manager_model.dart';
import '../models/rent_model.dart';

///Gerencia aluguéis
class RentState extends ChangeNotifier {
  ///Cliente selecionado
  String? customerSelected;

  ///Lista de estados do Brasi
  List<String> brazilianStates = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
  ];

  ///Controladores para os data de inicio
  final startDateController = TextEditingController();

  ///Controladores para os data final
  final endDateController = TextEditingController();

  ///Estado selecionado
  String? stateSelected;

  ///Gerente selecionado
  String? managerSelected;

  ///Veículo selecionado
  String? vehicleSelected;

  ///Lista de gerentes do estado selecionado
  List<ManagerModel> managersState = [];

  ///Lista de aluguéis
  final rents = <RentVehicleModel>[];

  ///Tabela de aluguéis
  final tableRents = TableRents();

  ///Data de início do aluguel
  DateTime? startDate;

  ///Data final do aluguel
  DateTime? endDate;

  ///Dias totais do aluguel
  int? totalDays;

  ///Inicializa a lista dos aluguéis
  RentState() {
    _initState();
    notifyListeners();
  }

  Future<void> _initState() async {
    rents
      ..clear()
      ..addAll(
        await tableRents.getRents(),
      );
    notifyListeners();
  }

  ///Inicia a lista
  Future<void> init() async {
    await _initState();
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

  ///Seleciona os gerentes de acordo com o estado
  Future<void> managerByState(String? state) async {
    managerSelected = null;
    managersState = [];

    if (state != null) {
      final dataBase = await getDatabase();
      final List<Map<String, dynamic>> managerMap = await dataBase.query(
        TableManagers.tableName,
        where: '${TableManagers.state} = ?',
        whereArgs: [state],
      );
      managersState = managerMap.map(ManagerModel.fromMapManager).toList();
    } else {
      managersState.clear();
    }
    notifyListeners();
  }

  ///Adicionar data de inicio do aluguel
  Future<void> getStartDate(BuildContext context) async {
    var selectedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    if (selectedStartDate != null) {
      startDate = selectedStartDate;
      startDateController.text = '$selectedStartDate'.split(' ')[0];
      notifyListeners();
    }
  }

  ///Adicionar data final do aluguel
  Future<void> getEndDate(BuildContext context) async {
    final selectedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    if (selectedEndDate != null && selectedEndDate != endDate) {
      endDate = selectedEndDate;
      endDateController.text = '$selectedEndDate'.split(' ')[0];
      _calculateTotalDays();
      notifyListeners();
    }
  }

  void _calculateTotalDays() {
    if (startDate != null && endDate != null) {
      totalDays = endDate!.difference(startDate!).inDays;
    } else {
      totalDays = null;
    }
  }
}
