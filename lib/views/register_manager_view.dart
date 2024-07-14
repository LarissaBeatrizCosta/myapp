import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../controllers/database.dart';
import '../models/manager_model.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TableManagers()),
      ],
      child: Scaffold(
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
                      Text(
                        AppLocalizations.of(context)!.registerManagerTitle,
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
                        controller: _numberPhoneController,
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
                        controller: _cpfController,
                        decoration: const InputDecoration(
                          labelText: 'CPF: ',
                        ),
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '###.###.###-##'),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.insertCPF;
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
                          labelText: AppLocalizations.of(context)!
                              .commissionPercentageLabel,
                          hintText: 'ex.10',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .insertPercentage;
                          } else if (value.contains('%')) {
                            return AppLocalizations.of(context)!
                                .percentageOnlyNumbers;
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Consumer<TableManagers>(
                              builder: (context, tableManagers, child) {
                            return Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(255, 195, 0, 1),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      tableManagers.insertManager(
                                        ManagerModel(
                                          cpf: _cpfController.text,
                                          name: _nameController.text,
                                          state: _stateController.text,
                                          phone: _numberPhoneController.text,
                                          salesCommission: double.parse(
                                            _percentageController.text,
                                          ),
                                        ),
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            height: 220,
                                            width: 300,
                                            child: AlertDialog(
                                              title: Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .managerRegistered,
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
                                                    Navigator
                                                        // Não consegui
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
                                                        color: Colors.black),
                                                  ),
                                                )
                                              ],
                                              elevation: 25,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(70.0),
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
                              ],
                            );
                          }),
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
