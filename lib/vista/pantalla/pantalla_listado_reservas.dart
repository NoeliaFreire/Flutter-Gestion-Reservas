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
  //Listado con las reservas del repositorio
  List<Reserva> _listaMostrada = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState(){
    super.initState();
    _listaMostrada = List.from(Repositorio().reservas);
  }

  void _actualizarLista(){
    setState(() {
      if (_controller.text.isEmpty) {
        _listaMostrada = List.from(Repositorio().reservas);
      }else{
        _listaMostrada = Repositorio().buscarPorCliente(_controller.text);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
        children: [
          SizedBox(height: 40,), //Espacio debajo del appBar
          TextField(
            controller: _controller, //Entrada de texto para busqueda
              decoration: InputDecoration(
                hintText: "Buscar reserva por cliente...", //Texto explicativo
                hintStyle: TextStyle(color: Colors.grey.shade400), //Color del texto explicativo
                prefixIcon: Icon(Icons.search), //Icono representativo
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none), //Borde redondeado y transparente
                filled: true, //Relleno del contenedor
                fillColor: Colors.white //Color de relleno
              ),
            onChanged: (value) {
              _actualizarLista();
            }, //Debería buscar, pero por incopatibilidad con el repositorio todavía no está integrado. Solo permite escribir
          ),
          SizedBox(height: 40,),
          Expanded(
            child:_listaMostrada.isEmpty ? const Center(child: Text("No se encontraron reservas"))
              : ListView.builder( //Organiza el contendio en una lista
                itemCount: _listaMostrada.length, //Modifica la longitud de la lista según el nº de reservas en la lista
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                itemBuilder: (context, index) {
                  final reserva = _listaMostrada[index]; //Obtiene la reserva de la lista por indice
                  return Dismissible( //Permite eliminar elementos deslizando
                    //Clave para identificar la reserva eliminada
                    key: Key(reserva.codigo.toString()),
                    //Dirección del deslizamiento
                    direction: DismissDirection.endToStart,
                    //Fondo al deslizar. Rojo para indicar la eliminación
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white,), //Icono representativo de la eliminación
                    ),
                    //Función que realiza al terminar de deslizar
                    onDismissed: (direccion){
                      //Eliminar reserva de la lista del repositorio
                      Repositorio().eliminarPorCodigo(reserva.codigo);
                      setState(() {
                        _listaMostrada.removeAt(index);
                      });
                      //Mostrar aviso de eliminación
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Reserva nº ${reserva.codigo} eliminada"))
                      );
                    },
                    child: ElementoListaReserva( //Contenedor de la reserva
                      reserva: reserva, //Reserva obtenida por indice
                      //Función al pulsar el contenedor de la reserva
                      //Navega a la pantalla detalle de la reserva seleccionada
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
            )
        ],
      ),
      ),
      //Botón para añadir una reserva. Navega a la pantalla del formulario
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 120, 139, 105), //Fondo del botón
        //Función al presionar. Navega a la pantalla formulario
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PantallaFormularioReserva(),
            ),
          ).then((value){
            //Al regresar al listado actualiza los datos
            _actualizarLista();
          });
        },
        child: const Icon(Icons.add, color: Colors.white), //Icono representativo del botón
      ),
    );
  }
}