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
        appBarTheme: AppBarTheme( //Tema para la appBar
          backgroundColor: Color.fromARGB(255, 23, 37, 33), //Color de fondo
          centerTitle: true, //Titulo centrado
          titleTextStyle: GoogleFonts.ebGaramond(
            fontSize: 24,
            color: Color(0xFFBDC5B7)
          ),
          iconTheme: IconThemeData(
            color: Color(0xFFBDC5B7),
          ),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 221, 230, 242), //Color de fondo de los Scaffold
        textTheme: GoogleFonts.latoTextTheme(),//Fuente personalizada para el resto de la aplicación
      ),
      home: PantallaPrincipal(), 
    );
  }
}