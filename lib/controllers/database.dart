import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/customer_model.dart';
import '../models/manager_model.dart';
import '../models/vehicles_model.dart';

///Cria banco de dados
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'aplicativo.db',
  );
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TableCustomers.createTable);
      db.execute(TableManagers.createTable);
      db.execute(TableVehicles.createTable);
    },
    version: 1,
  );
}

///Manipula os dados na tabela de clientes
class TableCustomers extends ChangeNotifier {
  ///Cria a tabela dos clientes
  static const String createTable = '''
  CREATE TABLE $tableName(
  $cnpj TEXT PRIMARY KEY,
  $name TEXT NOT NULL,
  $phone TEXT NOT NULL,
  $state TEXT NOT NULL,
  $city TEXT NOT NULL,

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
      TableCustomers.tableName,
      where: '${TableCustomers.cnpj} = ? ',
      whereArgs: [customer.cnpj],
    );
    notifyListeners();
  }

  ///Atualiza o cliente da tabela de clientes
  Future<void> updateCustomer(CustomerModel customer) async {
    final dataBase = await getDatabase();

    await dataBase.update(
      TableCustomers.tableName,
      customer.toMapCustomer(),
      where: '${TableCustomers.cnpj} = ? ',
      whereArgs: [customer.cnpj],
    );
    notifyListeners();
  }

  ///Pega os clientes da tabela de clientes
  Future<List<CustomerModel>> getCustomer() async {
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
    notifyListeners();

    for (var customer in customersMap) {
      customersList
          .add(CustomerModel.fromMapCustomer(customer as Map<String, dynamic>));
    }
    return customersList;
  }
}

///Manipula os dados na tabela de gerentes
class TableManagers extends ChangeNotifier {
  ///Cria a tabela dos gerentes
  static const String createTable = '''
  CREATE TABLE $tableName(
  $cpf TEXT PRIMARY KEY,
  $name TEXT NOT NULL,
  $phone TEXT NOT NULL,
  $state TEXT NOT NULL,
  $salesCommission TEXT NOT NULL
  );
  ''';

  ///Nome da tabela de gerentes
  static const String tableName = 'gerentes';

  ///Cpf do gerente
  static const String cpf = 'cpf';

  ///Nome do gerente
  static const String name = 'name';

  ///Telefone do gerente
  static const String phone = 'phone';

  ///Estado do gerente
  static const String state = 'state';

  ///Comissão do gerente
  static const String salesCommission = 'salesCommission';

  ///Insere os dados do gerente na tabela gerentes
  Future<void> insertManager(ManagerModel manager) async {
    final dataBase = await getDatabase();
    await dataBase.insert(tableName, manager.toMapManager());
    notifyListeners();
  }

  ///Deleta o gerente da tabela de gerentes
  Future<void> deleteManager(ManagerModel manager) async {
    final dataBase = await getDatabase();

    await dataBase.delete(
      TableManagers.tableName,
      where: '${TableManagers.cpf} = ? ',
      whereArgs: [manager.cpf],
    );
    notifyListeners();
  }

  ///Atualiza o gerente na tabela de gerentes
  Future<void> updateManager(ManagerModel manager) async {
    final dataBase = await getDatabase();

    await dataBase.update(
      TableManagers.tableName,
      manager.toMapManager(),
      where: '${TableManagers.cpf} = ? ',
      whereArgs: [manager.cpf],
    );
    notifyListeners();
  }

  /// Pega na tabela gerentes todos os gerentes
  Future<List<ManagerModel>> getManager() async {
    final dataBase = await getDatabase();
    var managersList = <ManagerModel>[];

    List<Map> managersMap = await dataBase.query(
      tableName,
      columns: [
        'cpf',
        'name',
        'phone',
        'state',
        'salesCommission',
      ],
    );
    notifyListeners();

    for (var manager in managersMap) {
      managersList
          .add(ManagerModel.fromMapManager(manager as Map<String, dynamic>));
    }
    return managersList;
  }
}

///Manipula os dados na tabela veículos
class TableVehicles extends ChangeNotifier {
  ///Cria a tabela dos veículos
  static const String createTable = '''
  CREATE TABLE $tableName(
  $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $type TEXT NOT NULL,
  $brand TEXT NOT NULL,
  $model TEXT NOT NULL,
  $plate TEXT NOT NULL,
  $manufacturingYear TEXT NOT NULL,
  $priceDaily TEXT NOT NULL
  );
''';

  ///Nome da tabela de veículos
  static const String tableName = 'veiculos';

  ///Identificação do veículo
  static const String id = 'id';

  ///Tipo do veículo
  static const String type = 'type';

  ///Marca do veículo
  static const String brand = 'brand';

  ///Modelo do veículo
  static const String model = 'model';

  ///Placa do veículo
  static const String plate = 'plate';

  ///Ano de fabricação do veículo
  static const String manufacturingYear = 'manufacturingYear';

  ///Preço do veículo
  static const String priceDaily = 'priceDaily';

  ///Insere os dados do veículo na tabela de veículos
  Future<void> insertVehicle(VehiclesModel vehicle) async {
    final dataBase = await getDatabase();
    await dataBase.insert(
      tableName,
      vehicle.toMapVehicles(),
    );
    notifyListeners();
  }

  ///Deleta o veículo da tabela de veículos
  Future<void> deleteVehicle(VehiclesModel vehicle) async {
    final dataBase = await getDatabase();

    await dataBase.delete(
      TableVehicles.tableName,
      where: '${TableVehicles.plate} = ? ',
      whereArgs: [vehicle.plate],
    );
    notifyListeners();
  }

  ///Atualiza o veículo na tabela de veículos
  Future<void> updateVehicle(VehiclesModel vehicle) async {
    final dataBase = await getDatabase();

    await dataBase.update(
      TableVehicles.tableName,
      vehicle.toMapVehicles(),
      where: '${TableVehicles.plate} = ? ',
      whereArgs: [vehicle.plate],
    );
    notifyListeners();
  }

  ///Pega os veículos da tabela de veículos
  Future<List<VehiclesModel>> getVehicle() async {
    final dataBase = await getDatabase();
    var vehiclesList = <VehiclesModel>[];

    List<Map> vehiclesMap = await dataBase.query(
      tableName,
      columns: [
        'id',
        'type',
        'brand',
        'model',
        'plate',
        'manufacturingYear',
        'priceDaily',
      ],
    );

    notifyListeners();

    for (var vehicle in vehiclesMap) {
      vehiclesList.add(
        VehiclesModel.fromMapVehicles(vehicle as Map<String, dynamic>),
      );
    }
    return vehiclesList;
  }
}
