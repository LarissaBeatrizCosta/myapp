import 'package:flutter/material.dart';

import '../models/customer_model.dart';
import '../providers/customers_state.dart';

///Tela para atualizar clientes
class UpdateCustomers extends StatelessWidget {
  ///Construtor de tela para atualizar clientes
  UpdateCustomers({super.key, required this.customer});

  ///Cliente que vai ser atualizado
  final CustomerModel customer;

  final _formKey = GlobalKey<FormState>();
  final _cnpjController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _cnpjController.text = customer.cnpj;
    _nameController.text = customer.name;
    _phoneController.text = customer.phone;
    _stateController.text = customer.state;
    _cityController.text = customer.city;

    final customerController = CustomersState();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Clientes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o estado';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe a cidade';
                  }
                  return null;
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 195, 0, 1),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var updatedCustomer = CustomerModel(
                          cnpj: _cnpjController.text,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          state: _stateController.text,
                          city: _cityController.text,
                        );

                        customerController.updateCustomers(updatedCustomer);
                        Navigator.pushNamed(context,
                            '/customers_view'); //todo: mudar para pop e ele continuar a atualizar
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
