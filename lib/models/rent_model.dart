import 'package:intl/intl.dart';

import 'customer_model.dart';

///Classe de aluguéis dos veículos
class RentVehicleModel {
  ///Indentificação do aluguel
  int? id;

  ///Cliente que vai alugar um veículo
  String cnpjCustomer;

  ///Data de início do aluguel
  DateTime startDate;

  ///Data final do aluguel
  DateTime finalDate;

  ///Diárias da locação
  int totalDays;

  ///Valor total da locação
  String rentPrice;

  ///Veículo que vai ser alugado
  String plateVehicle;

  ///Gerente responsável pelo aluguel
  String cpfManager;

  ///Comissão do gerente
  double commissionManager;

  ///Comissão do gerente
  CustomerModel? customer;

  ///Contrutor da classe de aluguéis dos veículos
  RentVehicleModel({
    this.id,
    required this.cnpjCustomer,
    required this.startDate,
    required this.finalDate,
    required this.totalDays,
    required this.rentPrice,
    required this.plateVehicle,
    required this.cpfManager,
    required this.commissionManager,
    this.customer,
  });

  ///Converte RentVehicleModel para mapa
  Map<String, dynamic> toMapRents() {
    return {
      'id': id,
      'cnpjCustomer': cnpjCustomer,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate),
      'finalDate': DateFormat('yyyy-MM-dd').format(finalDate),
      'totalDays': totalDays,
      'rentPrice': rentPrice,
      'plateVehicle': plateVehicle,
      'cpfManager': cpfManager,
      'commissionManager': commissionManager,
    };
  }

  ///Converte RentVehiclesModel do mapa
  factory RentVehicleModel.fromMapRents(
    Map<String, dynamic> map,
    CustomerModel? customer,
  ) {
    return RentVehicleModel(
      id: map['id'],
      cnpjCustomer: map['cnpjCustomer'],
      startDate: DateTime.tryParse(map['startDate']) ?? DateTime(0),
      finalDate: DateTime.tryParse(map['finalDate']) ?? DateTime(0),
      totalDays: map['totalDays'],
      rentPrice: map['rentPrice'],
      plateVehicle: map['plateVehicle'],
      cpfManager: map['cpfManager'],
      commissionManager: map['commissionManager'],
      customer: customer,
    );
  }
}
