import 'package:intl/intl.dart';
///Classe de aluguéis dos veículos
class RentVehicleModel {
  ///Indentificação do aluguel
  int? id;

  ///Cliente que vai alugar um veículo
  String nameCustomer;

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
  String nameManager;

  ///Comissão do gerente
  double commissionManager;

  ///Contrutor da classe de aluguéis dos veículos
  RentVehicleModel({
    this.id,
    required this.nameCustomer,
    required this.startDate,
    required this.finalDate,
    required this.totalDays,
    required this.rentPrice,
    required this.plateVehicle,
    required this.nameManager,
    required this.commissionManager,
  });

  ///Converte RentVehicleModel para mapa
  Map<String, dynamic> toMapRents() {
    return {
      'id': id,
      'nameCustomer': nameCustomer,
      'startDate': DateFormat('yyyy-MM-dd').format(startDate),
      'finalDate': DateFormat('yyyy-MM-dd').format(finalDate),
      'totalDays': totalDays,
      'rentPrice': rentPrice,
      'plateVehicle': plateVehicle,
      'nameManager': nameManager,
      'commissionManager': commissionManager,
    };
  }

  ///Converte RentVehiclesModel do mapa
  factory RentVehicleModel.fromMapRents(Map<String, dynamic> map) {
    return RentVehicleModel(
      id: map['id'],
      nameCustomer: map['nameCustomer'],
      startDate: DateTime.tryParse(map['startDate']) ?? DateTime(0),
      finalDate: DateTime.tryParse(map['finalDate']) ?? DateTime(0),
      totalDays: map['totalDays'],
      rentPrice: map['rentPrice'],
      plateVehicle: map['plateVehicle'],
      nameManager: map['nameManager'],
      commissionManager: map['commissionManager'],
    );
  }
}
