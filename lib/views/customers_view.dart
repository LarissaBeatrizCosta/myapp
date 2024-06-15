import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/customers_state.dart';
import '../providers/theme.dart';

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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Consumer<CustomersState>(builder: (context, state, _) {
            return ListView.builder(
              itemCount: state.costumers.length,
              itemBuilder: (context, index) {
                final customer = state.costumers[index];
                return ListTile(
                  title: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: stateTheme.themeLight ? Colors.white : Colors.black,
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
                                      color: stateTheme.themeLight
                                          ? const Color.fromRGBO(0, 29, 61, 1)
                                          : Colors.white,
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
                                  child: Text(customer.cnpj),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(customer.phone),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  child: Text(customer.state),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  child: Text(customer.city),
                                ),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  child: Text('gerente'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                state.deleteCustomers(customer);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
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
