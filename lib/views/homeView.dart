import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, "/"),
        ),
        backgroundColor: Color.fromARGB(255, 0, 29, 61),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Que bom ter você novamente aqui!",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(0, 11, 24, 1),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "SS Automóveis",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 11, 24, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
