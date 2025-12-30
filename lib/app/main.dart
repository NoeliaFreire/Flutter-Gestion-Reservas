import 'package:flutter/material.dart';
import '../vista/pantalla/pantalla_principal.dart';

void main() {
  runApp(const MiAppHotel());
}

class MiAppHotel extends StatelessWidget {
  const MiAppHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la banda de "debug"
      title: 'Gestión Reservas',
      home: const PantallaPrincipal(), // Aquí es donde cargas tu pantalla
    );
  }
}