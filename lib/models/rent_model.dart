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
  });

  ///Converte rentVehicleModel para mapa
  Map<String, dynamic> toMapRents() {
    return {
      'id': id,
      'cnpjCustomer': cnpjCustomer,
      'startDate': startDate,
      'finalDate': finalDate,
      'totalDays': totalDays,
      'rentPrice': rentPrice,
      'plateVehicle': plateVehicle,
      'cpfManager': cpfManager,
      'commissionManager': commissionManager,
    };
  }

  ///Converte rentVehiclesModel do mapa
  factory RentVehicleModel.fromMapVehicles(Map<String, dynamic> map) {
    return RentVehicleModel(
      id: map['id'],
      cnpjCustomer: map['cnpjCustomer'],
      startDate: map['startDate'],
      finalDate: map['finalDate'],
      totalDays: map['totalDays'],
      rentPrice: map['rentPrice'],
      plateVehicle: map['plateVehicle'],
      cpfManager: map['cpfManager'],
      commissionManager: map['commissionManager'],
    );
  }
}
