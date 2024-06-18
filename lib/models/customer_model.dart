/// Classe de clientes
class CustomerModel {
  
  /// Cnpj do cliente
  String cnpj;

  /// Nome do cliente
  String name;

  /// Telefone do cliente
  String phone;

  /// Estado do cliente
  String state;

  /// Cidade do cliente
  String city;

  /// Contrutor da classe de clientes
  CustomerModel({
    required this.cnpj,
    required this.name,
    required this.phone,
    required this.state,
    required this.city,
  });

/// Converte CustomerModel para mapa
  Map<String, dynamic> toMapCustomer() {
    return {
      'cnpj': cnpj,
      'phone': phone,
      'state': state,
      'city': city,
      'name': name,
    };
  }

///Converte CustomerModel do mapa 
  factory CustomerModel.fromMapCustomer(Map<String, dynamic> map) {
    return CustomerModel(
      cnpj: map['cnpj'],
      phone: map['phone'],
      state: map['state'],
      city: map['city'],
      name: map['name'],
    );
  }


}
