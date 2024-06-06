import 'package:flutter/material.dart';

/// Inicializa página inicial
class HomeView extends StatelessWidget {
/// Contrutor da página inicial
  const HomeView({super.key});

  /// Método que retorna a página inicial
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.account_circle_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
