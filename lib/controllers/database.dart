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
class TabelaClientes {
  ///Cria a atbela dos clientes
  static const String createTable = '''
  CREATE TABLE $tableName(
  $cnpj INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $name TEXT NOT NULL
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
  Future<void> insert(CustomerModel customer) async {
    final db = await getDatabase();
    await db.insert(tableName, customer.toMapCustomer());
  }
}
