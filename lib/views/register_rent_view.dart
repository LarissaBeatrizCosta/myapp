import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
