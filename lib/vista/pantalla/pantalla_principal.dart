import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_detalle_reserva.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_formulario_reserva.dart';
import 'package:xestion_reservas_hotel/vista/widgets/tarjeta_estado.dart';
import 'package:xestion_reservas_hotel/modelo/repositorio.dart';
import 'package:xestion_reservas_hotel/modelo/reserva.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_listado_reservas.dart';
import 'package:xestion_reservas_hotel/vista/widgets/contenido_principal.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  //Indice para la navegación entre pantallas
  int _indice = 0;

  @override
  void initState(){
    super.initState();
  }

  //Lista de pantallas para el BottonNavigationBar
  final List<Widget> _pantallas = [
    ContenidoPrincipal(),           //Contenido principal
    PantallaListadoReservas(), //Pantalla del listado
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //Toma el estilo del tema
        title: Text('EGO HOTEL',),
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.only(left: 40),
          child: Image.asset('assets/images/logoHotel.png',fit: BoxFit.contain),),
          actions: [
            IconButton(
              onPressed: (){
                return showAboutDialog(
                  context: context,
                  applicationName: 'Gestor Reservas Hotel Ego',
                  applicationIcon: Icon(Icons.info),
                  applicationVersion: '1.0.0'
                );}, 
              icon: Icon(Icons.info_outline))
          ], //Logo de la empresa
      ),
      body: _pantallas[_indice], //Cambia el contenido de la pantalla principal según la selección de la barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar( //Barra de navegación inferior
        currentIndex: _indice,
        selectedItemColor: Color.fromARGB(255, 120, 139, 105), //Color para la pantalla seleccionada
        items: [ //Iconos y texto explicativo
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Reservas')
        ],
        //Funcion al presionar
        onTap: (int nuevoindice){
          setState(() {
            _indice = nuevoindice;
          });
        },),
    );
  }
}
