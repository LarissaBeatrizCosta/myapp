import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../controllers/cnpj_controller.dart';
import '../controllers/database.dart';
import '../models/customer_model.dart';

/// Classe para o cadastro dos clientes
class RegisterCustomerView extends StatelessWidget {
  /// Construtor da Classe do RegisterCustomer
  RegisterCustomerView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _cnpjController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberPhoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CnpjController()),
        ChangeNotifierProvider(create: (context) => TableCustomers()),
      ],
      child: Scaffold(
        appBar: AppBar(),
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
                          labelText: 'Telefone:',
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
                          child: Consumer2<CnpjController, TableCustomers>(
                            builder: (context, cnpjController, tableCustomers,
                                child) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 195, 0, 1),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await Provider.of<CnpjController>(
                                                context,
                                                listen: false)
                                            .validateCnpj(_cnpjController.text,
                                                _nameController.text);
                                        if (cnpjController.validateName &&
                                            cnpjController.validateCNPJ) {
                                          tableCustomers.insertCustomer(
                                            CustomerModel(
                                              cnpj: _cnpjController.text,
                                              name: _nameController.text,
                                              phone:
                                                  _numberPhoneController.text,
                                              state: _stateController.text,
                                              city: _cityController.text,
                                            ),
                                          );
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                width: 300,
                                                height: 220,
                                                child: AlertDialog(
                                                  title: const Center(
                                                    child: Text(
                                                      'Cliente Cadastrado!',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            //Não consegui
                                                            //quebrar a linha
                                                            // ignore: lines_longer_than_80_chars
                                                            .pushNamedAndRemoveUntil(
                                                          context,
                                                          '/',
                                                          (route) => false,
                                                        );
                                                      },
                                                      child: const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )
                                                  ],
                                                  elevation: 25,
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            70.0),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
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
                                  const SizedBox(height: 20),
                                  Text(
                                    cnpjController.validationMessage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            },
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
      ),
    );
  }
}
