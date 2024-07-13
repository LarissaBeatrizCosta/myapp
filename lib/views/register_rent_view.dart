import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/database.dart';
import '../models/customer_model.dart';
import '../models/manager_model.dart';
import '../models/vehicles_model.dart';
import '../providers/customers_state.dart';
import '../providers/managers_state.dart';
import '../providers/rent_state.dart';
import '../providers/vehicles_state.dart';

/// Classe para o cadastro dos aluguéis
class RegisterRentView extends StatelessWidget {
  ///Construtor da classe de RegisterRentView
  RegisterRentView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RentState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomersState(),
        ),
        ChangeNotifierProvider(
          create: (context) => ManagersState(),
        ),
        ChangeNotifierProvider(
          create: (context) => VehiclesState(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableRents(),
        ),
      ],
      child: Consumer4<RentState, CustomersState, ManagersState, VehiclesState>(
          builder: (context, rentController, customerController,
              managerController, vehicleController, _) {
        var customersDrop = <DropdownMenuItem<CustomerModel>>[];

        for (var customerRent in customerController.customers) {
          customersDrop.add(
            DropdownMenuItem<CustomerModel>(
              value: customerRent,
              child: Text(customerRent.name),
            ),
          );
        }

        var vehiclesDrop = <DropdownMenuItem<VehiclesModel>>[];

        for (var vehicleRent in vehicleController.vehicles) {
          vehiclesDrop.add(
            DropdownMenuItem<VehiclesModel>(
              value: vehicleRent,
              child: Text('${vehicleRent.model} - ${vehicleRent.plate}'),
            ),
          );
        }
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
                          'Cadastro De Aluguéis',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 300,
                          child: DropdownButtonFormField<CustomerModel>(
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_sharp,
                              color: Color.fromRGBO(255, 195, 0, 1),
                            ),
                            value: rentController.customerSelected,
                            hint: const Text('Selecione o cliente'),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: const Text('Cliente'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: customersDrop,
                            onChanged: (value) {
                              rentController.customerSelected = value;
                            },
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
                            value: rentController.stateSelected,
                            hint: const Text('Selecione o estado'),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: const Text('Estado'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: rentController.brazilianStates
                                .map<DropdownMenuItem<String>>((state) {
                              return DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            onChanged: (value) {
                              rentController.stateSelected = value;
                              rentController.managerByState(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 300,
                          child: DropdownButtonFormField<ManagerModel>(
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_sharp,
                              color: Color.fromRGBO(255, 195, 0, 1),
                            ),
                            value: rentController.managerSelected,
                            hint: const Text('Selecione o gerente'),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: const Text('Gerente'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: rentController.managersState.map((manager) {
                              return DropdownMenuItem<ManagerModel>(
                                value: manager,
                                child: Text(manager.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              rentController.managerSelected = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 300,
                          child: DropdownButtonFormField<VehiclesModel>(
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_sharp,
                              color: Color.fromRGBO(255, 195, 0, 1),
                            ),
                            value: rentController.vehicleSelected,
                            hint: const Text('Selecione o veículo'),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: const Text('Veículo'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: vehiclesDrop,
                            onChanged: (value) {
                              rentController.vehicleSelected = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          canRequestFocus: false,
                          autofocus: false,
                          controller: rentController.startDateController,
                          decoration: const InputDecoration(
                              hintText: 'Data de início do aluguel'),
                          onTap: () {
                            rentController.getStartDate(context);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          canRequestFocus: false,
                          autofocus: false,
                          controller: rentController.endDateController,
                          decoration: const InputDecoration(
                              hintText: 'Data de final do aluguel'),
                          onTap: () {
                            rentController.getEndDate(context);
                          },
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Consumer<TableRents>(
                                builder: (context, tableRents, child) {
                              return Column(
                                children: [
                                  Text(
                                      'Preço ${rentController.getRentPrice()}'),
                                  Text(
                                      'Comissão: ${rentController.getManagerCommission()}'),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 195, 0, 1),
                                    ),
                                    onPressed: () async {
                                      if (rentController.customerSelected !=
                                              null &&
                                          rentController.managerSelected !=
                                              null &&
                                          rentController.vehicleSelected !=
                                              null &&
                                          rentController.stateSelected !=
                                              null) {
                                        // await tableRents.insertRents(
                                        //   RentVehicleModel(
                                        //     cnpjCustomer: rentController
                                        //         .customerSelected!,
                                        //     cpfManager:
                                        //    rentController.managerSelected!,
                                        // startDate:DateFormat('yyyy-MM-dd').format(rentController.startDate!),
                                        //   //finalDate: DateFormat('yyyy-MM-dd').format(rentController.endDate!),
                                        //     plateVehicle:
                                        //      rentController.vehicleSelected!,
                                        //     totalDays:
                                        //         rentController.totalDays!,
                                        //     rentPrice: '0',
                                        //     commissionManager: 0,
                                        //   ),
                                        // );

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 220,
                                              width: 300,
                                              child: AlertDialog(
                                                title: const Center(
                                                  child: Text(
                                                    'Aluguel Cadastrado!',
                                                    textAlign: TextAlign.center,
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
                                                      BorderRadius.circular(
                                                          70.0),
                                                ),
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
        );
      }),
    );
  }
}
