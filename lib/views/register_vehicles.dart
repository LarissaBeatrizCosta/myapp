import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/fipe_controller.dart';
import '../models/brand_vehicles.dart';

///Classe para cadastro de veiculos
class RegisterVehicleView extends StatelessWidget {
  /// Construtor da Classe de RegisterVehicleView
  RegisterVehicleView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _manufacturingYearController = TextEditingController();
  final _priceDailyController = TextEditingController();
  File? _photo;

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
                          'Cadastro De Veiculos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButton<String>(
                          value: fipeController.typeSelected,
                          hint: const Text('Selecione o veículo'),
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
                        const SizedBox(height: 20),
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
