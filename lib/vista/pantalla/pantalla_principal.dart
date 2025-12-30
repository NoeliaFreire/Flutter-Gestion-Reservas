import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Ego - Viveiro",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar reserva por cliente...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 20,),
            Text("Resumen de hoy", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: TarjetaEstado(titulo: "Check-in", numero: Repositorio().contarCheckInHoy(), colorFondo: Colors.green, icono: Icons.luggage, colorIcono: Colors.white)),
                Expanded(child: TarjetaEstado(titulo: "Check-in", numero: Repositorio().contarCheckInHoy(), colorFondo: Colors.green, icono: Icons.luggage, colorIcono: Colors.white))
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaListadoReservas()),);}, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ver listado de reservas",style: TextStyle(color: Colors.white),),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
            )
          ],
        ),
      )
    );
  }
}