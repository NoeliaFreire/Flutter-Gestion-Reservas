import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 94, 132, 199),
          centerTitle: true,
          titleTextStyle: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 221, 230, 242),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: PantallaPrincipal(), 
    );
  }
}