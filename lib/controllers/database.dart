import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/customer_model.dart';

///Cria banco de dados
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'aplicativo.db',
  );
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TabelaClientes.createTable);
    },
    version: 1,
  );
}

///Insere os dados na tabela de clientes
class TabelaClientes extends ChangeNotifier {
  ///Cria a atbela dos clientes
  static const String createTable = '''
  CREATE TABLE $tableName(
  $cnpj TEXT PRIMARY KEY,
  $name TEXT NOT NULL,
  $phone TEXT NOT NULL,
  $state TEXT NOT NULL,
  $city TEXT NOT NULL
  );
  ''';

  /// Nome da tabela clientes
  static const String tableName = 'clientes';

  /// Cnpj do cliente
  static const String cnpj = 'cnpj';

  /// Nome do cliente
  static const String name = 'name';

  /// Número dos clientes
  static const String phone = 'phone';

  /// Estado dos clientes
  static const String state = 'state';

  /// Cidade dos clientes
  static const String city = 'city';

  ///Insere os dados do cliente na tabela clientes
  Future<void> insertCustomer(CustomerModel customer) async {
    final dataBase = await getDatabase();
    await dataBase.insert(tableName, customer.toMapCustomer());
    notifyListeners();
  }

  ///Deleta o cliente da tabela de clientes
  Future<void> deleteCustomer(CustomerModel customer) async {
    final dataBase = await getDatabase();

    await dataBase.delete(
      TabelaClientes.tableName,
      where: '${TabelaClientes.cnpj} = ? ',
      whereArgs: [customer.cnpj],
    );
  }

  ///Atualiza o cliente da tabela de clientes
  Future<void> updateCustomer(CustomerModel customer) async {
    final dataBase = await getDatabase();

    await dataBase.update(
      TabelaClientes.tableName,
      customer.toMapCustomer(),
      where: '${TabelaClientes.cnpj} = ? ',
      whereArgs: [customer.cnpj],
    );
  }

  ///Pega os clientes da tabela de clientes
  Future<List<CustomerModel>> getCustomer(CustomerModel customer) async {
    final dataBase = await getDatabase();
    var customersList = <CustomerModel>[];

    List<Map> customersMap = await dataBase.query(
      tableName,
      columns: [
        'cnpj',
        'name',
        'phone',
        'state',
        'city',
      ],
    );

    for (var customer in customersMap) {
      customersList
          .add(CustomerModel.fromMapCustomer(customer as Map<String, dynamic>));
    }
    return customersList;
  }
}
