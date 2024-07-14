import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                      Text(
                        AppLocalizations.of(context)!.registerCustomerTitle,
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
                        controller: _cnpjController,
                        decoration: const InputDecoration(
                          labelText: 'CNPJ:',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.insertCNPJ;
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
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.cityLabel,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.insertCity;
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
                                                  title: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .customerRegistered,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
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
                                    child: Text(
                                      AppLocalizations.of(context)!.save,
                                      style: const TextStyle(
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
