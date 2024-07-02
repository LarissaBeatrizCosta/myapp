import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/image_picker_state.dart';
import '../providers/theme.dart';
import '../providers/vehicles_state.dart';
import 'update_vehicles.dart';

///Classe de vizualização dos veículos
class VehiclesView extends StatelessWidget {
  ///Construtor da tela de vizualizar veículos
  const VehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    final stateTheme = Provider.of<ThemeState>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VehiclesState(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickerState(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Veículos Cadastrados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 29, 61),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Consumer2<VehiclesState, ImagePickerState>(
            builder: (context, state, images, _) {
              return ListView.builder(
                itemCount: state.vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = state.vehicles[index];
                  return ListTile(
                    title: Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: stateTheme.themeLight
                          ? Colors.white
                          : const Color.fromARGB(82, 60, 68, 138),
                      shadowColor: Colors.blueGrey,
                      child: Row(
                        children: [
                          images.photoVehiclesPaths.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 50,
                                    width: 30,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: FileImage(
                                        File(images.photoVehiclesPaths[0]),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.photo,
                                  size: 70, color: Colors.grey),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.model,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: stateTheme.themeLight
                                          ? const Color.fromRGBO(255, 195, 0, 1)
                                          : const Color.fromARGB(
                                              255, 255, 225, 127),
                                    ),
                                  ),
                                  Text(
                                    vehicle.brand,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    vehicle.manufacturingYear,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    vehicle.plate,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    vehicle.priceDaily.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: const Color.fromARGB(255, 255, 0, 0),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        width: 200,
                                        height: 220,
                                        child: AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              'Excluir Veículo',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ),
                                          content: const Text(
                                            'Deseja excluir este veículo?',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                state.deleteVehicles(vehicle);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Confirmar',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                          elevation: 25,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: const Color.fromARGB(255, 60, 255, 0),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateVehicles(
                                        vehicle: vehicle,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
