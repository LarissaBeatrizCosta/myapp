import 'package:flutter/material.dart';

/// Inicializa tela de registro de cliente
class RegisterCustomer extends StatelessWidget {
  /// Contrutor da página de registro de clientes
  RegisterCustomer({super.key});
  final _formKey = GlobalKey<FormState>();
  final _cnpjController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberPhoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  /// Método que retorna a página de registro de clientes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 29, 61),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cadastro De Clientes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome:',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _numberPhoneController,
                      decoration: const InputDecoration(
                          labelText: 'Telefone:', hintText: '(xx) xxxxx-xxxx'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um telefone';
                        } else if (value.length < 11) {
                          return 'O telefone precisa ter 11 digitos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _cnpjController,
                      decoration: const InputDecoration(
                        labelText: 'CNPJ:',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um CNPJ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _stateController,
                      decoration: const InputDecoration(
                        labelText: 'Estado:',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um estado';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'Cidade:',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira uma cidade';
                        }
                        return null;
                      },
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(255, 195, 0, 1),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
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
            ],
          ),
        ),
      ),
    );
  }
}
