import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../controllers/database.dart';
import '../models/customer_model.dart';

///Gerencia os clientes
class CustomersState extends ChangeNotifier {
  ///Inicializa a lista de clientes
  CustomersState() {
    _initState();
    notifyListeners();
  }

  ///Lista de clientes do banco
  final controllerCustomers = TableCustomers(); // ver se usa

  ///Lista de Clientes State
  final customers = <CustomerModel>[];

  ///Inicializa a lista de  clientes
  void _initState() async {
    final tableCustomers = TableCustomers();

    customers
      ..clear()
      ..addAll(
        await tableCustomers.getCustomer(),
      );
    notifyListeners();
  }

  ///Deleta clientes
  void deleteCustomers(CustomerModel cnpj) async {
    final tableCustomers = TableCustomers();

    await tableCustomers.deleteCustomer(cnpj);
    customers.remove(cnpj);

    notifyListeners();
  }

  ///Atualiza os clientes
  void updateCustomers(CustomerModel cnpj) async {
    final tableCustomers = TableCustomers();

    await tableCustomers.updateCustomer(cnpj);
    notifyListeners();
  }
}
