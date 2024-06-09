/// Classe para validar o cnpj
class CnpjModel {
  /// Nome do cliente
  String name;

  /// Telefone do cliente
  String phone;

  /// Estado do cliente
  String state;

  /// Cidade do cliente
  String city;

  /// Contrutor da classe CnpjModel
  CnpjModel({
    required this.name,
    required this.phone,
    required this.state,
    required this.city,
  });

  /// Converte CnpjModel em Json
  static CnpjModel fromJson(Map<String, dynamic> json) { 

    return CnpjModel(
      name: json['name'],
      phone: json['phone'],
      state: json['state'],
      city: json['city'],
    );
  }
}
