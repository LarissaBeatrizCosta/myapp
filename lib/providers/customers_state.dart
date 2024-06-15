import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../controllers/database.dart';
import '../models/customer_model.dart';

///Gerencia os clientes
class CustomersState extends ChangeNotifier {
  ///Gerencia os clientes
  CustomersState() {
    _initState();
  }

  ///Lista de clientes do banco
  final controllerCustomers = TabelaClientes();

  ///Lista de Clientes State
  final costumers = <CustomerModel>[];

  void _initState() async {
    final tabela = TabelaClientes();

    costumers
      ..clear()
      ..addAll(
        await tabela.getCustomer(),
      );
    notifyListeners();
  }

  ///Deleta clientes
  void deleteCustomers(CustomerModel cnpj) async {
    final tabela = TabelaClientes();

    await tabela.deleteCustomer(cnpj);
    costumers.remove(cnpj);
    notifyListeners();
  }
}
