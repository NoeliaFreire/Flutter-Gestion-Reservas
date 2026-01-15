import 'package:flutter/material.dart';
import 'package:xestion_reservas_hotel/modelo/reserva.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_formulario_reserva.dart';

class PantallaDetalleReserva extends StatefulWidget {
  //Variable para acceder a los datos de cada reserva
  final Reserva reserva;

  const PantallaDetalleReserva({super.key, required this.reserva});

  @override
  State<PantallaDetalleReserva> createState() => _PantallaDetalleReservaState();
}

class _PantallaDetalleReservaState extends State<PantallaDetalleReserva> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de Reserva - ${widget.reserva.codigo}"), //Titulo de la pantalla
      ),
      body: SingleChildScrollView( //Permite un contenido más largo que la pantalla
        padding: const EdgeInsets.all(20), //Espacio interior del contenedor
        child: Column( //Ordena el contenido en una columna
          children: [ 
            // Datos de la reserva
            _campoDato("Nombre del Cliente", widget.reserva.cliente),
            _campoDato("Habitación", widget.reserva.habitacion.toString()),
            _campoDato("Fecha Entrada", "${widget.reserva.fechaInicio.day}/${widget.reserva.fechaInicio.month}/${widget.reserva.fechaInicio.year}"),
            _campoDato("Fecha Salida", "${widget.reserva.fechaFin.day}/${widget.reserva.fechaFin.month}/${widget.reserva.fechaFin.year}"),
            _campoDato("Importe Total", "${widget.reserva.importe} €"),
            _campoDato("Estado de la Reserva", widget.reserva.estado.name.toUpperCase()),

            const SizedBox(height: 50), //Espacio entre los datos y el botón de modificar

            //Botón para modificar datos de la reserva, navega al formulario pasando la reserva seleccionada  
            ElevatedButton(
              //Estilos del botón
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 120, 139, 105),
                minimumSize: const Size(double.infinity, 60), // Tamaño mínimo del botón
                shape: RoundedRectangleBorder( // Forma rectangular ancha
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              //Función al presionarlo
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Pasamos la reserva
                    builder: (context) => PantallaFormularioReserva(reserva: widget.reserva),
                  ),
                ).then((value) {
                  // Actualiza la pantalla al regresar del formulario
                  setState(() {});
                });
              },
              //Texto del botón
              child: const Text(
                "Modificar",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget para campo con los datos de la reserva, tiene una etiqueta explicativa y el valor de cada reserva 
Widget _campoDato(String etiqueta, String valor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row( //Ordena el contenido en una fila
      children: [
        SizedBox( //Contenedor para la etiqueta
          width: 120,
          child: Text(
            etiqueta,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color.fromARGB(255, 81, 81, 81),
            ),
          ),
        ),
        const SizedBox(width: 10), //Espacio horizontal entre la etiqueta y su valor
        Expanded(
          child: Container( //Contenedor para el valor
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, //Color de fondo
              borderRadius: BorderRadius.circular(10), //Borde circular
              boxShadow: [ //Sombra para el contenedor
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Text(
              valor,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}