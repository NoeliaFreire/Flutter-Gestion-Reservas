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
          backgroundColor: const Color.fromARGB(255, 94, 132, 199), //Color de fondo
          centerTitle: true, //Titulo centrado
          titleTextStyle: GoogleFonts.lora( //Fuente personalizada
            color: Colors.white, //Color de letra
            fontSize: 20, //Tamaño de la fuente
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 221, 230, 242), //Color de fondo de los Scaffold
        textTheme: GoogleFonts.latoTextTheme(),//Fuente personalizada para el resto de la aplicación
      ),
      home: PantallaPrincipal(), 
    );
  }
}