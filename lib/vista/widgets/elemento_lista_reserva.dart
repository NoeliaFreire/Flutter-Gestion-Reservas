import 'package:flutter/material.dart';
import '../../modelo/reserva.dart';

class ElementoListaReserva extends StatelessWidget {
  //Variable que define la reserva para poder acceder a los atributos de cada
  // una para mostrarlos
  final Reserva reserva;
  //Variable para la navegación al detalle de la reserva
  final VoidCallback onTap;
  const ElementoListaReserva({
    super.key,
    required this.reserva,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: Icon(Icons.person, color: Colors.green,),
            ),
            SizedBox(height: 15,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reserva.cliente,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Habitación: ${reserva.habitacion}",
                      style: TextStyle(
                        color: Colors.grey.shade600
                      ),
                    ),
                    SizedBox(width: 15,),
                    Text(
                      "Check-in: ${reserva.fechaInicio.day}/${reserva.fechaInicio.month}/${reserva.fechaInicio.year}",
                      style: TextStyle(
                          color: Colors.grey.shade600
                        ),
                    ),
                    SizedBox(width: 15,),
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