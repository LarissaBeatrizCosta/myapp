///Classe de modelos de veiculos
class ModelVehiclesModel {
  ///Identificação do modelo
  String id;

  ///Nome do modelo
  String name;

  ///Construtor da classe de modelos de veiculos
  ModelVehiclesModel({
    required this.id,
    required this.name,
  });

  ///Converte ModelVehiclesModel para mapa
  Map<String, dynamic> toMapModelVehicles() {//Verificar se irá utilizar
    return {
      'id': id,
      'name': name,
    };
  }
  ///Converte ModelVehiclesModel do mapa
  factory ModelVehiclesModel.fromMapModelVehicles(Map<String, dynamic> map) {
    return ModelVehiclesModel(
      id: map['code'],
      name: map['name'],
    );
  }
}
