import 'package:flutter/material.dart';
import 'package:xestion_reservas_hotel/modelo/reserva.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_formulario_reserva.dart';

class PantallaDetalleReserva extends StatefulWidget {
  final Reserva reserva;
  const PantallaDetalleReserva({super.key, required this.reserva});

  @override
  State<PantallaDetalleReserva> createState() => _PantallaDetalleReservaState();
}

class _PantallaDetalleReservaState extends State<PantallaDetalleReserva> {
  @override
  Widget build(BuildContext context) {
    // Usamos widget.reserva para acceder a los datos en un StatefulWidget
    final r = widget.reserva;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de Reserva - ${r.codigo}"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _campoDato("Nombre del Cliente", r.cliente),
            _campoDato("Habitación", r.habitacion.toString()),
            _campoDato("Fecha Entrada", "${r.fechaInicio.day}/${r.fechaInicio.month}/${r.fechaInicio.year}"),
            _campoDato("Fecha Salida", "${r.fechaFin.day}/${r.fechaFin.month}/${r.fechaFin.year}"),
            _campoDato("Importe Total", "${r.importe} €"),
            _campoDato("Estado de la Reserva", r.estado.name.toUpperCase()),
            const SizedBox(height: 50),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 60), // Forma rectangular ancha
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // PASAMOS LA RESERVA y quitamos el 'const'
                    builder: (context) => PantallaFormularioReserva(reserva: r),
                  ),
                ).then((value) {
                  // ESTO ACTUALIZA LA PANTALLA AL VOLVER
                  setState(() {});
                });
              },
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

// El widget _campoDato se mantiene igual fuera de la clase
Widget _campoDato(String etiqueta, String valor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        SizedBox(
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
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
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