import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../providers/managers_state.dart';
import '../providers/theme.dart';
import 'update_managers_view.dart';

///Classe para vizualização da lista de gerentes
class ManagersView extends StatelessWidget {
  ///Construtor da tela de vizualizar gerentes
  const ManagersView({super.key});

  @override
  Widget build(BuildContext context) {
    final stateTheme = Provider.of<ThemeState>(context);

    return ChangeNotifierProvider(
      create: (context) => ManagersState(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.registeredManagers,
            style: const TextStyle(
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
          child: Consumer<ManagersState>(
            builder: (context, state, _) {
              return ListView.builder(
                itemCount: state.managers.length,
                itemBuilder: (context, index) {
                  final manager = state.managers[index];
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
                                        horizontal: 10.0, vertical: 10.0),
                                    child: Text(
                                      manager.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: stateTheme.themeLight
                                            ? const Color.fromRGBO(
                                                255, 195, 0, 1)
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
                                      'CPF: ${manager.cpf}',
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
                                        horizontal: 10.0, vertical: 1.0),
                                    child: Text(
                                      manager.phone,
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
                                        horizontal: 10.0, vertical: 1.0),
                                    child: Text(
                                      manager.state,
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
                                        horizontal: 10.0, vertical: 1.0),
                                    child: Text(
                                      '${AppLocalizations.of(context)!.commission}: ${manager.salesCommission}%',
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
                                        width: 300,
                                        height: 220,
                                        child: AlertDialog(
                                          title: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .deleteManagerTitle,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ),
                                          content: Text(
                                            AppLocalizations.of(context)!
                                                .deleteManagerMessage,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .cancel,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                state.deleteManagers(manager);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .confirm,
                                                style: const TextStyle(
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
                                      builder: (context) => UpdateManagers(
                                        manager: manager,
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
