import 'package:flutter/material.dart';

class TarjetaEstado extends StatelessWidget {
  //Variable para el titulo de la tarjeta
  final String titulo;
  //Variable númerica que indica el total de reservas para ese día
  final int numero;
  //Variable para establecer el color de fondo del widget
  final Color colorFondo;
  //Variable para definir el icono que aparece en el widget
  final IconData icono;
  //Variable para deefinir el color del icono
  final Color colorIcono;

  const TarjetaEstado({
    super.key,
    required this.titulo,
    required this.numero,
    required this.colorFondo,
    required this.icono,
    required this.colorIcono
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0.5),
        boxShadow: [
          BoxShadow(
            color: colorFondo.withOpacity(0.5),
            offset: const Offset(0, 2),
            blurRadius: 4
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icono,
            color: colorIcono,
            size: 32,
          ),
          const SizedBox(height: 10),
          Text(
            titulo, 
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'Hoy: $numero',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}