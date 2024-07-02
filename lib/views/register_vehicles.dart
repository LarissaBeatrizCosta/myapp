import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../controllers/database.dart';
import '../controllers/fipe_controller.dart';
import '../models/brand_vehicles_model.dart';
import '../models/model_vehicles_model.dart';
import '../models/vehicles_model.dart';
import '../providers/image_picker_state.dart';
import '../providers/theme.dart';

///Tela de cadastro de veiculos
class RegisterVehicleView extends StatelessWidget {
  ///Contrutor da tela de cadastro de veiculos
  RegisterVehicleView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _manufacturingYearController = TextEditingController();
  final _priceDailyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FipeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickerState(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableVehicles(),
        ),
      ],
      child: Consumer2<FipeController, ImagePickerState>(builder: (
        context,
        fipeController,
        imagePickerController,
        _,
      ) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
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
                            hint: const Text('Selecione o tipo de veículo'),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: const Text('Tipo de veículo'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
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
                            hint: const Text('Selecione a marca'),
                            decoration: InputDecoration(
                              label: const Text('Marca'),
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
                            hint: const Text('Selecione o modelo'),
                            decoration: InputDecoration(
                              label: const Text('Modelo'),
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
                              return 'Insira um preço diário';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 7, 55, 94),
                                          child: Center(
                                            child: Icon(
                                              Icons.photo_camera,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        title: const Text('Câmera'),
                                        onTap: () async {
                                          await imagePickerController
                                              .getImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: const CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 7, 55, 94),
                                          child: Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        title: const Text('Galeria'),
                                        onTap: () async {
                                          await imagePickerController
                                              .getImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.attach_file,
                            color: state.themeLight
                                ? const Color.fromARGB(255, 46, 46, 46)
                                : Colors.white,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          label: Text(
                            'Anexar Fotos',
                            style: TextStyle(
                              color: state.themeLight
                                  ? const Color.fromARGB(255, 46, 46, 46)
                                  : Colors.white,
                            ),
                          ),
                        ),
                        Consumer<ImagePickerState>(
                          builder: (context, imagePickerController, _) {
                            return imagePickerController
                                    .photoVehicles.isNotEmpty
                                ? SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: imagePickerController
                                          .photoVehicles.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.file(
                                            File(imagePickerController
                                                .photoVehicles[index].path),
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container();
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Consumer2<FipeController, TableVehicles>(
                              builder:
                                  (context, fipeController, tableVehicles, _) {
                                return Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            255, 195, 0, 1),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate() &&
                                            fipeController.modelSelected !=
                                                null) {
                                          List<XFile>? savedPhotos;
                                          if (imagePickerController
                                              .photoVehicles.isNotEmpty) {
                                            await imagePickerController
                                                .saveImageVehicle();
                                            savedPhotos = imagePickerController
                                                .photoVehicles;
                                          }
                                          await tableVehicles.insertVehicle(
                                            VehiclesModel(
                                              type:
                                                  fipeController.typeSelected!,
                                              brand: fipeController
                                                  .brandSelected!.name,
                                              model: fipeController
                                                  .modelSelected!.name,
                                              manufacturingYear:
                                                  _manufacturingYearController
                                                      .text,
                                              plate: _plateController.text,
                                              priceDaily:
                                                  _priceDailyController.text,
                                              photos: savedPhotos,
                                            ),
                                          );
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: SizedBox(
                                                  height: 220,
                                                  width: 300,
                                                  child: AlertDialog(
                                                    title: const Center(
                                                      child: Text(
                                                        'Veículo Cadastrado!',
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
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        70.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          fipeController.validationMessage =
                                              'Selecione todos os campos';
                                          fipeController.notifyListeners();
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
