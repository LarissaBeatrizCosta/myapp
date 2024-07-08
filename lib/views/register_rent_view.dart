import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/database.dart';
import '../providers/customers_state.dart';
import '../providers/rent_state.dart';
// import '../providers/theme.dart';

/// Classe para o cadastro dos aluguéis
class RegisterRentView extends StatelessWidget {
  ///Construtor da classe de RegisterRentView
  RegisterRentView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<ThemeState>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RentState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomersState(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableRents(),
        ),
      ],
      child: Consumer2<RentState, CustomersState>(
          builder: (context, rentController, customerController, _) {
        var customersDrop = <DropdownMenuItem<String>>[];

        for (var rent in rentController.rents) {
          customersDrop.add(DropdownMenuItem<String>(
            value: rent.cnpjCustomer,
            child: Text(rent.cnpjCustomer),
          ));
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
                          child: DropdownButtonFormField<String>(
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
                            items: customersDrop.map((customer) {
                              return customer;
                            }).toList(),
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
                            value: rentController.customerSelected,
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
                            items: customersDrop.map((customer) {
                              return customer;
                            }).toList(),
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
                            value: rentController.customerSelected,
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
                            items: customersDrop.map((customer) {
                              return customer;
                            }).toList(),
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
                            value: rentController.customerSelected,
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
                            items: customersDrop.map((customer) {
                              return customer;
                            }).toList(),
                            onChanged: (value) {
                              rentController.customerSelected = value;
                            },
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Consumer<TableRents>(
                                builder: (context, tableRents, child) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 195, 0, 1),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 220,
                                              width: 300,
                                              child: AlertDialog(
                                                title: const Center(
                                                  child: Text(
                                                    'Gerente Cadastrado!',
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
