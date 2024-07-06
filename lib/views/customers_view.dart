import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/customers_state.dart';
import '../providers/theme.dart';
import 'update_customers_view.dart';

///Classe para vizualizar lista de clientes
class CustomersView extends StatelessWidget {
  ///Construtor da tela de vizualizar clientes
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    final stateTheme = Provider.of<ThemeState>(context);


    return ChangeNotifierProvider(
      create: (context) => CustomersState(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clientes Cadastrados',
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
          child: Consumer<CustomersState>(builder: (context, state, _) {
            return ListView.builder(
              itemCount: state.customers.length,
              itemBuilder: (context, index) {
                final customer = state.customers[index];
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text(
                                    customer.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: stateTheme.themeLight
                                          ? const Color.fromRGBO(255, 195, 0, 1)
                                          : const Color.fromARGB(
                                              255, 255, 225, 127),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 1.0),
                                  child: Text(
                                    'CNPJ: ${customer.cnpj}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    customer.phone,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  child: Text(
                                    customer.state,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  child: Text(
                                    customer.city,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                                      height: 220,
                                      width: 300,
                                      child: AlertDialog(
                                        title: const Center(
                                          child: Text(
                                            'Excluir Cliente',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                        content: const Text(
                                          'Deseja excluir este cliente?',
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
                                              state.deleteCustomers(customer);
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
                                    builder: (context) => UpdateCustomers(
                                      customer: customer,
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
          }),
        ),
      ),
    );
  }
}
