import 'package:flutter/material.dart';
import 'package:xestion_reservas_hotel/vista/widgets/tarjeta_estado.dart';
import 'package:xestion_reservas_hotel/modelo/repositorio.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_formulario_reserva.dart';

//Contenido de la pantalla principal
class ContenidoPrincipal extends StatelessWidget {
  const ContenidoPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    //Calculamos los datos de entrada y salida antes de dibujar
    int checkIns = Repositorio().contarCheckInHoy(); 
    int checkOuts = Repositorio().contarCheckOutHoy(); 
    return Stack( //Permite apilar widgets
      children: [
        Container( //Contenedor para el fondo de pantalla
          width: double.infinity, //Ocupa todo el ancho del contenedor
          height: double.infinity, //Ocupa todo el alto del contenedor
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fondo_pantalla_principal.jpg"), //Imagen de fondo
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
                  Expanded(child: TarjetaEstado(titulo: "Check-in", numero: checkIns, colorFondo: Colors.green, icono: Icons.luggage, colorIcono: Colors.white)),
                  //Etiqueta de estado de reservas con fecha de salida en el día en el que se encuentra
                  Expanded(child: TarjetaEstado(titulo: "Check-out", numero: checkOuts, colorFondo: Colors.red, icono: Icons.door_sliding, colorIcono: Colors.white))
                ],
              ),
              SizedBox(height: 50,),
              ElevatedButton( //Botón para navegar a la pantalla formulario
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaFormularioReserva()),);},  //Navega a la pantalla formulario
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 120, 139, 105),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),)), //Estilo del botón
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