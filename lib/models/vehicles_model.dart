///Classe de modelos de veiculos
class VehiclesModel {
  ///Identificação do veiculo
  int? id;

  ///Identificação da tipo de veículo
  String type;

  ///Identificação da marca
  String brand;

  ///Identificação do modelo
  String model;

  ///Placa do veiculo
  String plate;

  ///Ano de fabricação do veiculo
  String manufacturingYear;

  ///Preço da diária
  double priceDaily;

  ///Construtor da classe de modelos de veiculos
  VehiclesModel({
    this.id,
    required this.type,
    required this.brand,
    required this.model,
    required this.plate,
    required this.manufacturingYear,
    required this.priceDaily,
  });

  ///Converte VehiclesModel para mapa
  Map<String, dynamic> toMapVehicles() {
    return {
      'id': id,
      'type': type,
      'brand': brand,
      'model': model,
      'plate': plate,
      'manufacturingYear': manufacturingYear,
      'priceDaily': priceDaily,
    };
  }

  ///Converte VehiclesModel do mapa
  factory VehiclesModel.fromMapVehicles(Map<String, dynamic> map) {
    return VehiclesModel(
      id: map['id'],
      type: map['type'],
      brand: map['brand'],
      model: map['model'],
      plate: map['plate'],
      manufacturingYear: map['manufacturingYear'],
      priceDaily: map['priceDaily'],
    );
  }
}
