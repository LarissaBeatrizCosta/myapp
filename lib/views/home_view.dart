import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme.dart';

/// Inicializa página inicial
class HomeView extends StatelessWidget {
  /// Contrutor da página inicial
  const HomeView({super.key});

  /// Método que retorna a página inicial
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 29, 61),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Que bom ter você novamente aqui!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'SS Automóveis',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Novos Cadastros',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/register_customer'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 100),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(22),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.account_circle_sharp,
                                color: Color.fromRGBO(255, 195, 0, 1),
                                size: 40,
                              ),
                              Text(
                                'Clientes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state.themeLight
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 100),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(22),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.supervisor_account,
                                color: Color.fromRGBO(255, 195, 0, 1),
                                size: 40,
                              ),
                              Text(
                                'Gerentes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state.themeLight
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 100),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.drive_eta,
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                  size: 40,
                                ),
                                Text(
                                  'Veiculos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: state.themeLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 100),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.payments,
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                  size: 40,
                                ),
                                Text(
                                  'Aluguéis',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: state.themeLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Relatórios e Alterações',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 100),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(22),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.assignment_ind,
                                color: Color.fromRGBO(255, 195, 0, 1),
                                size: 40,
                              ),
                              Text(
                                'Clientes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state.themeLight
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 100),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(22),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.assignment,
                                color: Color.fromRGBO(255, 195, 0, 1),
                                size: 40,
                              ),
                              Text(
                                'Gerentes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state.themeLight
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 100),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.car_repair,
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                  size: 40,
                                ),
                                Text(
                                  'Veiculos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: state.themeLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 100),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.description,
                                  color: Color.fromRGBO(255, 195, 0, 1),
                                  size: 40,
                                ),
                                Text(
                                  'Aluguéis',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: state.themeLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
