import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/manager_model.dart';
import '../providers/managers_state.dart';

///Tela de atualizar gerentes
class UpdateManagers extends StatelessWidget {
  ///Construtor de tela para atualizar gerentes
  UpdateManagers({super.key, required this.manager});

  ///Gerente que vai ser atualizado
  final ManagerModel manager;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = manager.name;
    _phoneController.text = manager.phone;
    _stateController.text = manager.state;
    _percentageController.text = manager.salesCommission;

    final managerController = ManagersState();

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
                'Editar Gerentes',
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
                    return 'Por favor, informe um nome';
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
                      backgroundColor: const Color.fromRGBO(255, 195, 0, 1),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var updatedManager = ManagerModel(
                          cpf: manager.cpf,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          state: _stateController.text,
                          salesCommission: _percentageController.text,
                        );

                        managerController.updateManagers(updatedManager);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/managers', (route) => false);
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
