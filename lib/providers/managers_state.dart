import 'package:flutter/material.dart';

import '../controllers/database.dart';
import '../models/manager_model.dart';

///Gerencia os gerentes
class ManagersState extends ChangeNotifier {
  ///Inicializa a lista de gerentes
  ManagersState() {
    _initState();
    notifyListeners();
  }

  ///Lista de gerentes
  final managers = <ManagerModel>[];

  ///Tabela de gerentes
  final tableManagers = TableManagers();

  ///Inicializa a lista de gerentes
  void _initState() async {
    managers
      ..clear()
      ..addAll(
        await tableManagers.getManager(),
      );
    notifyListeners();
  }

  ///Deleta gerentes
  void deleteManagers(ManagerModel cpf) async {
    await tableManagers.deleteManager(cpf);
    managers.remove(cpf);
    notifyListeners();
  }

  ///Atualiza os gerentes
  void updateManagers(ManagerModel cpf) async {
    await tableManagers.updateManager(cpf);
    notifyListeners();
  }

  ///Adiciona os gerentes
  void addManagers(ManagerModel cpf) async {
    await tableManagers.insertManager(cpf);
    managers.add(cpf);
    notifyListeners();
  }

  //diferenças do state do clientes,
  //add o adicionar e não tem lista ..controller
}
