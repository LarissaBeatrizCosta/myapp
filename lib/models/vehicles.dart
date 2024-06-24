///Classe de modelos de veiculos
class VehiclesModel {
  ///Identificação do veiculo
  int id;

  ///Identificação da marca
  int idBrand;

  ///Identificação do modelo
  int idModel;

  ///Placa do veiculo
  String plate;

  ///Ano de fabricação do veiculo
  int manufacturingYear;

  ///Preço da diária
  double priceDaily;

  ///Fotos do veiculo
  String? photos;

  ///Construtor da classe de modelos de veiculos
  VehiclesModel({
    required this.id,
    required this.idBrand,
    required this.idModel,
    required this.plate,
    required this.manufacturingYear,
    required this.priceDaily,
    this.photos,
  });

  ///Converte VehiclesModel para mapa
  Map<String, dynamic> toMapVehicles() {
    return {
      'id': id,
      'idBrand': idBrand,
      'idModel': idModel,
      'plate': plate,
      'manufacturingYear': manufacturingYear,
      'priceDaily': priceDaily,
      'photos': photos,
    };
  }

  ///Converte VehiclesModel do mapa
  factory VehiclesModel.fromMapVehicles(Map<String, dynamic> map) {
    return VehiclesModel(
      id: map['id'],
      idBrand: map['idBrand'],
      idModel: map['idModel'],
      plate: map['plate'],
      manufacturingYear: map['manufacturingYear'],
      priceDaily: map['priceDaily'],
      photos: map['photos'],
    );
  }
}
