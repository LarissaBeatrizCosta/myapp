import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../controllers/fipe_controller.dart';
import '../models/brand_vehicles_model.dart';
import '../models/model_vehicles_model.dart';
import '../models/vehicles_model.dart';
import '../providers/vehicles_state.dart';

///Tela de atualizar de veículos

class UpdateVehicles extends StatelessWidget {
  ///Contrutor da tela de atualizar de veículos
  UpdateVehicles({super.key, required this.vehicle});

  ///Veículo a ser atualizado
  final VehiclesModel vehicle;
  final _formKey = GlobalKey<FormState>();
  final _manufacturingYearController = TextEditingController();
  final _priceDailyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _manufacturingYearController.text = vehicle.manufacturingYear;
    _priceDailyController.text = vehicle.priceDaily.toString();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FipeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => VehiclesState(),
        ),
      ],
      child: Consumer<FipeController>(
        builder: (context, fipeController, _) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.updateVehicleTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 300,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Color.fromRGBO(255, 195, 0, 1),
                          ),
                          value: fipeController.typeSelected,
                          hint: Text(
                              AppLocalizations.of(context)!.selectVehicleType),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(255, 195, 0, 1),
                              ),
                            ),
                            label:
                                Text(AppLocalizations.of(context)!.vehicleType),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!
                                  .selectVehicleTypeValidation;
                            }
                            return null;
                          },
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
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 300,
                        child: DropdownButtonFormField<BrandVehiclesModel>(
                          isExpanded: true,
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Color.fromRGBO(255, 196, 0, 1),
                          ),
                          value: fipeController.brandSelected,
                          hint: Text(AppLocalizations.of(context)!.selectBrand),
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.brand),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(255, 195, 0, 1),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!
                                  .selectBrandValidation;
                            }
                            return null;
                          },
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
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: DropdownButtonFormField<ModelVehiclesModel>(
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_sharp,
                            color: Color.fromRGBO(255, 196, 0, 1),
                          ),
                          isExpanded: true,
                          value: fipeController.modelSelected,
                          hint: Text(AppLocalizations.of(context)!.selectModel),
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.model),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(255, 195, 0, 1),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!
                                  .selectModelValidation;
                            }
                            return null;
                          },
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
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _manufacturingYearController,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.manufacturingYear,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .manufacturingYearValidation;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _priceDailyController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.plate,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .plateValidation;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Consumer2<FipeController, VehiclesState>(
                            builder:
                                (context, fipeController, vehicleState, _) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 195, 0, 1),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate() &&
                                          fipeController.modelSelected !=
                                              null) {
                                        var updatedVehicle = VehiclesModel(
                                          id: vehicle.id, // Add this line
                                          type: fipeController.typeSelected!,
                                          brand: fipeController
                                              .brandSelected!.name,
                                          model: fipeController
                                              .modelSelected!.name,
                                          manufacturingYear:
                                              _manufacturingYearController.text,
                                          plate: vehicle.plate,
                                          priceDaily: double.parse(
                                              _priceDailyController.text),
                                        );

                                        vehicleState
                                            .updateVehicles(updatedVehicle);

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              width: 300,
                                              height: 220,
                                              child: AlertDialog(
                                                title: Center(
                                                  child: Text(
                                                    //Não consegui quebrar linha
                                                    // ignore: lines_longer_than_80_chars
                                                    AppLocalizations.of(
                                                            context)!
                                                        .successDialogTitleVehicle,
                                                    textAlign: TextAlign.center,
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
                                                              '/vehicles',
                                                              (route) => false);
                                                    },
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
