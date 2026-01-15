import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_detalle_reserva.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_formulario_reserva.dart';
import 'package:xestion_reservas_hotel/vista/widgets/tarjeta_estado.dart';
import '../../modelo/reserva.dart';
import '../../modelo/repositorio.dart';
import '../pantalla/pantalla_listado_reservas.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  //Indice para la navegación entre pantallas
  int _indice = 0;

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
        leadingWidth: 130,
        leading: Padding(
          padding: EdgeInsets.only(left: 60),
          child: Image.asset('assets/logoHotel.png',fit: BoxFit.contain),),
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
        selectedItemColor: Colors.blue, //Color para la pantalla seleccionada
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

//Contenido de la pantalla principal
class ContenidoPrincipal extends StatelessWidget {
  const ContenidoPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack( //Permite apilar widgets
      children: [
        Container( //Contenedor para el fondo de pantalla
          width: double.infinity, //Ocupa todo el ancho del contenedor
          height: double.infinity, //Ocupa todo el alto del contenedor
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fondo_pantalla_principal.jpg"), //Imagen de fondo
              fit: BoxFit.cover, //Ajusta la imagen para que ocupe todo el espacio
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), //Capa oscura sobre la imagen
                BlendMode.darken, //Mezcla el color con la imagen
              ),
            ),
          ),
        ),
        SingleChildScrollView( //Permite un contenido más largo que la pantalla
          padding: EdgeInsets.all(15), //Espaciado interior
          child: Column( //Ordena el contenido en una columna
            crossAxisAlignment: CrossAxisAlignment.center, //Centra el contenido
            children: [
              SizedBox(height: 30,),
              Row( //Fila para las etiquetas de estado
                children: [
                  //Etiqueta de estado de reservas con fecha de entrada del día en el que se encuentra
                  Expanded(child: TarjetaEstado(titulo: "Check-in", numero: Repositorio().contarCheckInHoy(), colorFondo: Colors.green, icono: Icons.luggage, colorIcono: Colors.white)),
                  //Etiqueta de estado de reservas con fecha de salida en el día en el que se encuentra
                  Expanded(child: TarjetaEstado(titulo: "Check-out", numero: Repositorio().contarCheckOutHoy(), colorFondo: Colors.red, icono: Icons.door_sliding, colorIcono: Colors.white))
                ],
              ),
              SizedBox(height: 50,),
              ElevatedButton( //Botón para navegar a la pantalla formulario
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaFormularioReserva()),);},  //Navega a la pantalla formulario
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),)), //Estilo del botón
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Centra el texto en el centro del botón
                  mainAxisSize: MainAxisSize.min, //Tamaño del botón según su contenido
                  children: [
                    Text("Crear reserva",style: TextStyle(color: Colors.white, fontSize: 20)), //Texto explicativo
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward_ios, color: Colors.white,) //Icono representativo
                  ],
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}