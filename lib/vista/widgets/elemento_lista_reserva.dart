import 'package:flutter/material.dart';
import '../../modelo/reserva.dart';

class ElementoListaReserva extends StatelessWidget {
  //Define una reserva para acceder a los atributos y mostrarlos
  final Reserva reserva;

  //Funcion para la navegación al detalle de la reserva
  final VoidCallback onTap;

  const ElementoListaReserva({
    super.key,
    required this.reserva,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //Detecta el toque para navegar a la pantalla detalle
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), //Espaciado exterior 
        padding: EdgeInsets.all(12), //Espaciado interior
        decoration: BoxDecoration(
          color: Colors.white, //Color de fondo del contenedor
          borderRadius: BorderRadius.circular(10), //Borde redondeado
          ),
        child: Row( //Ordena el contenido en una fila
          children: [
            Container(
              width: 50, //Ancho fijo
              height: 50, //Altura fija
              decoration: BoxDecoration(
                shape: BoxShape.circle //Forma cirular para el icono
              ),
              child: Icon(reserva.icono, color: Colors.green,), //Icono de la reserva de color verde
            ),
            SizedBox(height: 15,), //Espacio horizontal
            Expanded( //Ocupa todo el espacio disponible del contenedor
              child: Column( //Muestra en columna los datos 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reserva.cliente,
                style: TextStyle(
                  fontWeight: FontWeight.bold, //Nombre en negrita
                  fontSize: 16 //Tamaño del texto
                ),),
                SizedBox(height: 5,), //Espacio horizontal
                Wrap( //Agrupa los datos si caben en una fila, si no salta a la siguiente linea
                  spacing: 10, //Espacio horizontal entre elementos
                  runSpacing: 5, //Espacio vertical si salta de línea
                  children: [
                    //NÚMERO DE HABITACIÓN
                    Text(
                      "Habitación: ${reserva.habitacion}",
                      style: TextStyle(
                        color: Colors.grey.shade600
                      ),
                    ),
                    SizedBox(width: 10,),
                    //FECHA DE ENTRADA
                    Text(
                      "Check-in: ${reserva.fechaInicio.day}/${reserva.fechaInicio.month}/${reserva.fechaInicio.year}",
                      style: TextStyle(
                          color: Colors.grey.shade600
                        ),
                    ),
                    SizedBox(width: 10,),
                    //FECHA DE SALIDA
                    Text("Check-out: ${reserva.fechaFin.day}/${reserva.fechaFin.month}/${reserva.fechaFin.year}",
                      style: TextStyle(
                          color: Colors.grey.shade600
                      ),
                    ),
                      ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}