import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/customer_model.dart';
import '../models/manager_model.dart';
import '../models/rent_model.dart';
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
      db.execute(TableRents.createTable);

      final customer = CustomerModel(
          cnpj: '7527808500173',
          name: 'LINCE',
          phone: '999999999',
          state: 'SC',
          city: 'Gaspar');
      db.insert(
        TableCustomers.tableName,
        customer.toMapCustomer(),
      );

      final manager = ManagerModel(
          cpf: '10911918914',
          name: 'Larissa',
          phone: '999999999',
          state: 'SC',
          salesCommission: 10.0);
      db.insert(
        TableManagers.tableName,
        manager.toMapManager(),
      );

      final manager2 = ManagerModel(
          cpf: '10818819818',
          name: 'Eduarda',
          phone: '999999999',
          state: 'SC',
          salesCommission: 5.0);
      db.insert(TableManagers.tableName, manager2.toMapManager());

      final vehicle = VehiclesModel(
        type: 'Carro',
        brand: 'BMW',
        model: 'BMW 118i',
        plate: 'ABC1234',
        manufacturingYear: '2022',
        priceDaily: 100.50,
      );
      db.insert(TableVehicles.tableName, vehicle.toMapVehicles());
    },
    version: 1,
  );
}

///Manipula os dados na tabela de clientes
class TableCustomers extends ChangeNotifier {
  ///Cria a tabela dos clientes
  static const String createTable = '''
  CREATE TABLE $tableName(
  $cnpj TEXT PRIMARY KEY NOT NULL,
  $name TEXT NOT NULL,
  $phone TEXT NOT NULL,
  $state TEXT NOT NULL,
  $city TEXT NOT NULL
  );
  ''';

  /// Nome da tabela clientes
  static const String tableName = 'customers';

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
  $cpf TEXT PRIMARY KEY NOT NULL,
  $name TEXT NOT NULL,
  $phone TEXT NOT NULL,
  $state TEXT NOT NULL,
  $salesCommission TEXT NOT NULL
  );
  ''';

  ///Nome da tabela de gerentes
  static const String tableName = 'managers';

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
  $priceDaily REAL NOT NULL
  );
''';

  ///Nome da tabela de veículos
  static const String tableName = 'vehicles';

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

///Manipula os dados na tabela de aluguéis
class TableRents extends ChangeNotifier {
  ///Cria a tabela dos aluguéis
  static const String createTable = '''
CREATE TABLE $tableName(
  $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $nameCustomer TEXT NOT NULL,
  $startDate TEXT NOT NULL,
  $finalDate TEXT NOT NULL,
  $totalDays INTEGER NOT NULL,
  $rentPrice TEXT NOT NULL,
  $plateVehicle TEXT NOT NULL,
  $nameManager TEXT NOT NULL,
  $commissionManager REAL NOT NULL

);
''';

  ///Nome da tabela de aluguéis
  static const String tableName = 'rents';

  ///Indentificação do aluguel
  static const String id = 'id';

  ///Cliente que vai alugar
  static const String nameCustomer = 'nameCustomer';

  ///Data de início do aluguel
  static const String startDate = ' startDate';

  ///Data final do aluguel
  static const String finalDate = 'finalDate';

  ///Diárias do aluguel
  static const String totalDays = 'totalDays';

  ///Valor total do aluguel
  static const String rentPrice = 'rentPrice';

  ///Veículo que vai ser alugado
  static const String plateVehicle = 'plateVehicle';

  ///Gerente responsável pelo aluguel
  static const String nameManager = 'nameManager';

  ///Comissão do gerente
  static const String commissionManager = 'commissionManager';

  ///Insere os dados do aluguel
  Future<void> insertRents(RentVehicleModel rent) async {
    final dataBase = await getDatabase();
    await dataBase.insert(tableName, rent.toMapRents());
    notifyListeners();
  }

  ///Deleta o aluguel da tabela de aluguéis
  Future<void> deleteRents(RentVehicleModel rent) async {
    final dataBase = await getDatabase();
    await dataBase.delete(
      TableRents.tableName,
      where: '${TableRents.id} = ? ',
      whereArgs: [rent.id],
    );
  }

  ///Atualiza o aluguel da tabela de aluguéis
  Future<void> updateRents(RentVehicleModel rent) async {
    final dataBase = await getDatabase();
    await dataBase.update(
      TableRents.tableName,
      rent.toMapRents(),
      where: '${TableRents.id} = ? ',
      whereArgs: [rent.id],
    );
    notifyListeners();
  }

  ///Pega os aluguéis da tabela de aluguéis
  Future<List<RentVehicleModel>> getRents() async {
    final dataBase = await getDatabase();
    var rentsList = <RentVehicleModel>[];
    List<Map> rentsMap = await dataBase.query(
      tableName,
      columns: [
        'id',
        'nameCustomer',
        'startDate',
        'finalDate',
        'totalDays',
        'rentPrice',
        'plateVehicle',
        'nameManager',
        'commissionManager',
      ],
    );
    notifyListeners();
    for (var rent in rentsMap) {
      rentsList
          .add(RentVehicleModel.fromMapRents(rent as Map<String, dynamic>));
    }
    return rentsList;
  }
}
