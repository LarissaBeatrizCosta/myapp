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
  final tableCustomers = TableCustomers();

  ///Lista de Clientes State
  final customers = <CustomerModel>[];

  ///Cliente que fará o aluguel
  String? customerSelected;

  ///Inicializa a lista de  clientes
  void _initState() async {
    customers
      ..clear()
      ..addAll(
        await tableCustomers.getCustomer(),
      );
    notifyListeners();
  }

  ///Deleta clientes
  void deleteCustomers(CustomerModel cnpj) async {
    await tableCustomers.deleteCustomer(cnpj);
    customers.remove(cnpj);

    notifyListeners();
  }

  ///Atualiza os clientes
  void updateCustomers(CustomerModel cnpj) async {
    await tableCustomers.updateCustomer(cnpj);
    notifyListeners();
  }
  
}
