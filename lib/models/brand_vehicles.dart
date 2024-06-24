/// Classe de marcas de veiculos
class BrandVehiclesModel {
  ///Identificação do viculo
  String id;

  ///Nome do Veiculo
  String name;

  ///Contrutor das classe de marcas de veiculos
  BrandVehiclesModel({
    required this.id,
    required this.name,
  });

  ////Converte BrandVehiclesModel para mapa
  Map<String, dynamic> toMapBrandVehicles() {
    return {
      'id': id,
      'name': name,
    };
  }

  ///Converte BrandVehiclesModel do mapa
  factory BrandVehiclesModel.fromMapBrandVehicles(Map<String, dynamic> map) {
    return BrandVehiclesModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
