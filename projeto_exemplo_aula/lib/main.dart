import 'package:flutter/material.dart';
import 'package:projeto_exemplo_aula/feature/mercado/mercado_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MercadoPage(),
    );
  }
}
