import 'package:flutter/material.dart';
import 'package:xestion_reservas_hotel/vista/pantalla/pantalla_formulario_reserva.dart';
import '../../modelo/repositorio.dart';
import '../../modelo/reserva.dart';
import '../widgets/elemento_lista_reserva.dart';
import '../pantalla/pantalla_detalle_reserva.dart';
import '../pantalla/pantalla_principal.dart';

class PantallaListadoReservas extends StatefulWidget {
  const PantallaListadoReservas({super.key});

  @override
  State<PantallaListadoReservas> createState() => _PantallaListadoReservasState();
}

class _PantallaListadoReservasState extends State<PantallaListadoReservas> {
  final List<Reserva> _listaEjemplo = Repositorio().obtenerTodas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 230, 242),
      appBar: AppBar(
        title: Text("Hotel Ego - Viveiro",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _listaEjemplo.length,
        itemBuilder: (context,index){
          final reserva = _listaEjemplo[index];
          return ElementoListaReserva(reserva: reserva, onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaDetalleReserva(reserva: reserva,)));
          });
        },),
        floatingActionButton: FloatingActionButton(
          onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) =>PantallaFormularioReserva()));},
          child: Icon(Icons.add),
        ),
         bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Reservas')
        ],
        onTap: (indice){
          if(indice == 0){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaPrincipal()));
          }
          if(indice == 1){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaListadoReservas()));
          }
        },),
    );
  }
}