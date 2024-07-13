///Classe de gerentes
class ManagerModel {
  ///Cpf do cliente
  String cpf;

  ///Nome do gerente
  String name;

  ///Estado do gerente
  String state;

  ///Telefone do gerente
  String phone;

  ///Comissão do gerente
  double salesCommission; // AQUI

  ///Construtor da classe de gerentes
  ManagerModel({
    required this.cpf,
    required this.name,
    required this.state,
    required this.phone,
    required this.salesCommission,
  });

  ///Converte ManagerModel para mapa
  Map<String, dynamic> toMapManager() {
    return {
      'cpf': cpf,
      'name': name,
      'state': state,
      'phone': phone,
      'salesCommission': salesCommission,
    };
  }

  ///Converte o mapa para um ManagerModel
  factory ManagerModel.fromMapManager(Map<String, dynamic> map) {
    return ManagerModel(
      cpf: map['cpf'],
      name: map['name'],
      state: map['state'],
      phone: map['phone'],
      salesCommission: double.parse(map['salesCommission']),
    );
  }
}
