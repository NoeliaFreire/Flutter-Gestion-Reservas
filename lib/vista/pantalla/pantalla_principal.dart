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
      backgroundColor: const Color.fromARGB(255, 221, 230, 242),
      appBar: AppBar(
        title: Text("Hotel Ego - Viveiro",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar reserva por cliente...",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white
              ),
              onSubmitted: (value) {
              },
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(child: TarjetaEstado(titulo: "Check-in", numero: Repositorio().contarCheckInHoy(), colorFondo: Colors.green, icono: Icons.luggage, colorIcono: Colors.white)),
                Expanded(child: TarjetaEstado(titulo: "Check-out", numero: Repositorio().contarCheckOutHoy(), colorFondo: Colors.red, icono: Icons.door_sliding, colorIcono: Colors.white))
              ],
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaListadoReservas()),);}, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Ver listado de reservas",style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(width: 10,),
                  Icon(Icons.arrow_forward_ios, color: Colors.white,)
                ],
              )
            )
          ],
        ),
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