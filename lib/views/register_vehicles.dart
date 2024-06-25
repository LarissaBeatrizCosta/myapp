import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/fipe_controller.dart';
import '../models/brand_vehicles.dart';
import '../models/model_vehicles.dart';

///Tela de cadastro de veiculos
class RegisterVehicleView extends StatelessWidget {
  ///Contrutor da tela de cadastro de veiculos
  RegisterVehicleView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _manufacturingYearController = TextEditingController();
  final _priceDailyController = TextEditingController();
  // File? _photo;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FipeController(),
        ),
      ],
      child: Consumer<FipeController>(builder: (context, fipeController, _) {
        return Scaffold(
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
                          'Cadastro De Veículos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButton<String>(
                          value: fipeController.typeSelected,
                          hint: const Text('Selecione o tipo de veículo'),
                          items: fipeController.typesVehicles
                              .map<DropdownMenuItem<String>>((typeVehicle) {
                            return DropdownMenuItem<String>(
                              value: typeVehicle,
                              child: Text(typeVehicle),
                              
                            );
                          }).toList(),
                          onChanged: (value) {
                            fipeController.typeSelected = value;
                            fipeController.getBrandVehicles();
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        DropdownButton<BrandVehiclesModel>(
                          value: fipeController.brandSelected,
                          hint: const Text('Selecione a marca'),
                          items: fipeController.brandVehicles
                              .map<DropdownMenuItem<BrandVehiclesModel>>(
                                  (brand) {
                            return DropdownMenuItem<BrandVehiclesModel>(
                              value: brand,
                              child: Text(brand.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            fipeController.brandSelected = value;
                            fipeController.getModelVehicles();
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButton<ModelVehiclesModel>(
                          value: fipeController.modelSelected,
                          hint: const Text('Selecione o modelo'),
                          items: fipeController.modelVehicles
                              .map<DropdownMenuItem<ModelVehiclesModel>>(
                                  (model) {
                            return DropdownMenuItem<ModelVehiclesModel>(
                              value: model,
                              child: Text(model.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            fipeController.modelSelected = value;
                            fipeController.notifyListeners();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _manufacturingYearController,
                          decoration: const InputDecoration(
                            labelText: 'Ano de fabricação: ',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira um ano de fabricação';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _plateController,
                          decoration: const InputDecoration(
                            labelText: 'Placa: ',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira uma placa';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _priceDailyController,
                          decoration: const InputDecoration(
                            labelText: 'Preço Diária: ',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira um preço diária';
                            }
                            return null;
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Consumer<FipeController>(
                              builder: (context, fipeController, _) {
                                return Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            255, 195, 0, 1),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 50,
                                                    ),
                                                    child: Text(
                                                      'Veículo Cadastrado!',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator
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
                                                      BorderRadius.circular(
                                                          70.0),
                                                ),
                                              );
                                            },
                                          );
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
                                      fipeController.validationMessage,
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
        );
      }),
    );
  }
}
