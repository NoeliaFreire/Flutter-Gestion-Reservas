import 'package:flutter/material.dart';
import '../../modelo/repositorio.dart';
import '../../modelo/reserva.dart';
import '../widgets/elemento_lista_reserva.dart';
import '../pantalla/pantalla_detalle_reserva.dart';
import 'pantalla_formulario_reserva.dart';

class PantallaListadoReservas extends StatefulWidget {
  const PantallaListadoReservas({super.key});

  @override
  State<PantallaListadoReservas> createState() => _PantallaListadoReservasState();
}

class _PantallaListadoReservasState extends State<PantallaListadoReservas> {
  final List<Reserva> _listaReservas = Repositorio().obtenerTodas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _listaReservas.length,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        itemBuilder: (context, index) {
          final reserva = _listaReservas[index];
          return Dismissible(
            //Clave para identificar la reserva eliminada
            key: Key(reserva.codigo.toString()),
            //Dirección del deslizamiento
            direction: DismissDirection.endToStart,
            //Fondo al deslizar. Rojo para indicar la eliminación
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white,),
            ),
            //Función que realiza al terminar de deslizar
            onDismissed: (direccion){
              //Eliminar reserva de la lista del repositorio
              Repositorio().eliminarPorCodigo(reserva.codigo);
              //Mostrar aviso de eliminación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Reserva nº ${reserva.codigo} eliminada"))
              );
            },
            child: ElementoListaReserva(
              reserva: reserva,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaDetalleReserva(reserva: reserva),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 94, 132, 199),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PantallaFormularioReserva(),
            ),
          ).then((value){
            setState(() {} );
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}