import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/database.dart';
import '../models/customer_model.dart';
import '../models/manager_model.dart';
import '../models/vehicles_model.dart';
import '../providers/customers_state.dart';
import '../providers/image_picker_state.dart';
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
        ChangeNotifierProvider(
          create: (context) => ImagePickerState(),
        ),
      ],
      child: Consumer5<RentState, CustomersState, ManagersState, VehiclesState,
          ImagePickerState>(builder: (
        context,
        rentController,
        customerController,
        managerController,
        vehicleController,
        imagePickerController,
        _,
      ) {
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
                        Text(
                          AppLocalizations.of(context)!.titleRentsRegister,
                          style: const TextStyle(
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
                            hint: Text(
                              AppLocalizations.of(context)!.selectCustomer,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.customerLabel,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .customerValidationError;
                              }
                              return null;
                            },
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
                            hint: Text(
                              AppLocalizations.of(context)!.selectState,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.stateLabel,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .stateValidationError;
                              }
                              return null;
                            },
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
                            hint: Text(
                              AppLocalizations.of(context)!.selectManager,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.managerLabel,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .managerValidationError;
                              }
                              return null;
                            },
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
                            hint: Text(
                              AppLocalizations.of(context)!.selectVehicle,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                ),
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.vehicleLabel,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .vehicleValidationError;
                              }
                              return null;
                            },
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
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .rentalStartDateHint),
                          validator: (value) {
                            if (rentController.startDate == null) {
                              return AppLocalizations.of(context)!
                                  .startDateValidationMessage;
                            }
                            return null;
                          },
                          onTap: () {
                            rentController.getStartDate(context);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          canRequestFocus: false,
                          autofocus: false,
                          controller: rentController.endDateController,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .rentalEndDateHint),
                          validator: (value) {
                            if (rentController.endDate == null) {
                              return AppLocalizations.of(context)!
                                  .endDateValidationMessage;
                            }
                            return null;
                          },
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
                                    '${AppLocalizations.of(context)!.priceLabel} ${rentController.getRentPrice()}',
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context)!.commission} ${rentController.getManagerCommission()}',
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 195, 0, 1),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final rent = rentController.getRent();
                                        await tableRents.insertRents(rent);

                                        await rentController.generatePdf(
                                          rentController.customerSelected!,
                                          rentController.managerSelected!,
                                          rentController.vehicleSelected!,
                                          rent,
                                          imagePickerController,
                                        );

                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        final file = File(
                                            '${directory.path}/comprovante_${rent.id}.pdf');

                                        if (await file.exists()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Center(
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .rentalReceiptTitle,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                ),
                                                content: SizedBox(
                                                  width: double.maxFinite,
                                                  height: 400,
                                                  child: SfPdfViewer.file(file),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, '/');
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .closeButton,
                                                      style: const TextStyle(
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
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  AppLocalizations.of(context)!
                                                      .receiptNotFoundTitle,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                                content: Text(
                                                  AppLocalizations.of(context)!
                                                      .receiptNotFoundMessage,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
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
