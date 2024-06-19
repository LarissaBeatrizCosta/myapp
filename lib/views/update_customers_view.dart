import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/customer_model.dart';
import '../providers/customers_state.dart';

///Tela para atualizar clientes
class UpdateCustomers extends StatelessWidget {
  ///Construtor de tela para atualizar clientes
  UpdateCustomers({super.key, required this.customer});

  ///Cliente que vai ser atualizado
  final CustomerModel customer;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: '(xx) xxxxx-xxxx',
                ),
                inputFormatters: [
                  MaskTextInputFormatter(mask: '(##) #####-####'),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um telefone';
                  } else if (value.length < 10) {
                    return 'O telefone precisa ter 10 digitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  hintText: 'UF',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um estado';
                  } else if (value.length > 2) {
                    return 'Digite o UF de seu estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
                          cnpj: customer.cnpj,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          state: _stateController.text,
                          city: _cityController.text,
                        );

                        customerController.updateCustomers(updatedCustomer);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/customers_view', (route) => false);
                        // Enzo me ajudou na daily,
                        //retira todas as páginas que estavam atrás
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
