import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    _percentageController.text = manager.salesCommission.toString();

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
              Text(
                AppLocalizations.of(context)!.updateManagerTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.nameLabel,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.insertName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.phoneLabel,
                  hintText: '(xx) xxxxx-xxxx',
                ),
                inputFormatters: [
                  MaskTextInputFormatter(mask: '(##) #####-####'),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.insertPhone;
                  } else if (value.length < 10) {
                    return AppLocalizations.of(context)!.phoneDigits;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.stateLabel,
                  hintText: 'UF',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.insertState;
                  } else if (value.length > 2) {
                    return AppLocalizations.of(context)!.stateUF;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _percentageController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)!.commissionPercentageLabel,
                  hintText: 'ex.10',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.insertPercentage;
                  } else if (value.contains('%')) {
                    return AppLocalizations.of(context)!.percentageOnlyNumbers;
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
                          salesCommission:
                              double.parse(_percentageController.text), // AQUI
                        );

                        managerController.updateManagers(updatedManager);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              width: 300,
                              height: 220,
                              child: AlertDialog(
                                title: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .successDialogTitleManager,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/managers', (route) => false);
                                      // Enzo me ajudou na daily,
                                      //retira todas as páginas que estavam
                                      // atrás
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                                elevation: 25,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70.0),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: const TextStyle(
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
