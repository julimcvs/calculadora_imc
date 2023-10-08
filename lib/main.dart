import 'package:flutter/material.dart';
import 'package:calculadora_imc/screens/calculadora_imc.dart';
import 'package:calculadora_imc/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/imc': (context) => CalculadoraImc(),
      },
    );
  }
}