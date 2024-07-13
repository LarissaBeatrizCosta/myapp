// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/rent_state.dart';
// import '../providers/theme.dart';

// ///Classe de vizualização dos aluguéis
// class RentsView extends StatelessWidget {
//   ///Construtor da tela de visualizar aluguéis
//   const RentsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final stateTheme = Provider.of<ThemeState>(context);
//     return ChangeNotifierProvider(
//       create: (context) => RentState(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Aluguéis Cadastrados',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () => Navigator.pushNamed(context, '/'),
//           ),
//           backgroundColor: const Color.fromARGB(255, 0, 29, 61),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
//           child: Consumer<RentState>(
//             builder: (context, state, _) {
//               return ListView.builder(
//                 itemCount: state.rents.length,
//                 itemBuilder: (context, index) {
//                   final rent = state.rents[index];
//                   return ListTile(
//                     title: Card(),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
