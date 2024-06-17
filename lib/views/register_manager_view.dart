import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

///Classe para cadastro de gerentes
class RegisterManagerView extends StatelessWidget {
  /// Construtor da Classe de RegisterManagerView
  RegisterManagerView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberPhoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cadastro De Gerentes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome: ',
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
                        labelText: 'Telefone: ',
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
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: 'CPF: ',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um CPF';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _stateController,
                      decoration: const InputDecoration(
                        labelText: 'Estado: ',
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
                      controller: _percentageController,
                      decoration: const InputDecoration(
                        labelText: 'Porcentagem de comissão:',
                        hintText: 'ex.10',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira uma porcentagem';
                        } else if (value.contains('%')) {
                          return 'Digite apenas números';
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context); // exemplo
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
            ],
          ),
        ),
      ),
    );
  }
}
