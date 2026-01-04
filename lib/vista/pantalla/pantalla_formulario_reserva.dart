import 'package:flutter/material.dart';
import 'package:xestion_reservas_hotel/modelo/reserva.dart';
import 'package:xestion_reservas_hotel/modelo/repositorio.dart';

class PantallaFormularioReserva extends StatefulWidget {
  //Variable para controlar si se trata de formulario de creación o de modificación
  final Reserva? reserva;

  const PantallaFormularioReserva({super.key, this.reserva});

  @override
  State<PantallaFormularioReserva> createState() => _PantallaFormularioReservaState();
}

class _PantallaFormularioReservaState extends State<PantallaFormularioReserva> {
  //Llave global para validar
  final _formLlave = GlobalKey<FormState>();
  
  //Controladores para los campos del formulario
  final _controladorCliente = TextEditingController();
  final _controladorHabitacion = TextEditingController();
  final _controladorImporte = TextEditingController();
  //Variables para controlar datos no textuales
  EstadoReserva _estadoReserva = EstadoReserva.pendiente;
  DateTime _fechaInicio = DateTime.now();
  DateTime _fechaFin = DateTime.now();
  IconData _icono = Icons.person;
  //Variable para comprobar validez del formulario
  bool _esValido = false;

  //Lista de iconos para la selección
  final List<IconData> _iconosDisponibles = [
    Icons.hotel,
    Icons.beach_access,
    Icons.bed,
    Icons.family_restroom,
    Icons.business_center,
    Icons.star
  ];

  void dispose(){
    _controladorCliente.dispose();
    _controladorHabitacion.dispose();
    _controladorImporte.dispose();
    super.dispose();
  }

  //Función para seleccion de fecha
  void _pedirFecha(bool esInicio) async{
    DateTime? seleccion = await showDatePicker(
      context: context, 
      firstDate: DateTime(2024), lastDate: DateTime(2030)
    );

    if (seleccion != null) {
      setState(() {
        if (esInicio) {
          _fechaInicio = seleccion;
        }else{
          _fechaFin = seleccion;
        }
      });
    }
  }

  //Función para mostrar las opciones de iconos
  void _mostrarIcono(){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Selecciona un icono"),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: _iconosDisponibles.length,
              itemBuilder: (context,indice){
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _icono = _iconosDisponibles[indice];
                    });
                    Navigator.pop(context);
                  }, 
                  icon: Icon(_iconosDisponibles[indice], 
                  size: 35,
                  color: Colors.green,
                  )
                );
              },
            ),
          ),
        );
      }
    );
  }

  //Función para añadir datos en caso de modificación
  void initState(){
    super.initState();
    if(widget.reserva != null){
      _controladorCliente.text = widget.reserva!.cliente;
      _controladorHabitacion.text = widget.reserva!.habitacion.toString();
      _controladorImporte.text = widget.reserva!.importe.toString();
      _fechaInicio = widget.reserva!.fechaInicio;
      _fechaFin = widget.reserva!.fechaFin;
      _estadoReserva = widget.reserva!.estado;
      _icono = widget.reserva!.icono;
    }
    //Validación para cambio de color en el botón
    _revisarValidacion();
  }

  //Función para guardar la reserva
  void _guardar(){
    if (_formLlave.currentState!.validate()) {
      if (widget.reserva == null) {
        //FORMULARIO CREAR
        Reserva nueva = Reserva(
          codigo: Repositorio().generarCodigo(), 
          cliente: _controladorCliente.text, 
          habitacion: int.parse(_controladorHabitacion.text), 
          fechaInicio: _fechaInicio, 
          fechaFin: _fechaFin, 
          estado: _estadoReserva, 
          importe: double.parse(_controladorImporte.text),
          icono: _icono);

          Repositorio().agregar(nueva);
      }else{
        //FORMULARIO MODIFICAR: El código se mantiene
        widget.reserva!.cliente = _controladorCliente.text;
        widget.reserva!.habitacion = int.parse(_controladorHabitacion.text);
        widget.reserva!.importe = double.parse(_controladorImporte.text);
        widget.reserva!.fechaInicio = _fechaInicio;
        widget.reserva!.fechaFin = _fechaFin;
        widget.reserva!.estado = _estadoReserva;
        widget.reserva!.icono = _icono;
      }
      Navigator.pop(context);
    }
  }

  //Función para validar cada vez que el usuario escribe un campo
  void _revisarValidacion(){
    setState(() {
      bool nombreOk = _controladorCliente.text.isNotEmpty;
      bool habitacionOk = _controladorHabitacion.text.isNotEmpty;
      bool importeOk = double.tryParse(_controladorImporte.text) != null;

      _esValido = nombreOk && habitacionOk && importeOk;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.reserva == null ? "Nueva Reserva" : "Editar Reserva"),),
      body: Form(
        key: _formLlave,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            //ICONO
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _mostrarIcono,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(_icono, size: 50, color: Colors.green,),
                    ),
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
            SizedBox(height: 30,),
            //CLIENTE
            TextFormField(
              controller: _controladorCliente,
              decoration: InputDecoration(
                labelText: "Nombre Cliente",
                icon: Icon(Icons.person)
              ),
              onChanged: (value) => _revisarValidacion(),
              validator: (v) => v!.isEmpty ? "Nombre imcompleto" : null,
            ),
            //HABITACIÓN
             TextFormField(
              controller: _controladorHabitacion,
              decoration: InputDecoration(
                labelText: "Habitacion",
                icon: Icon(Icons.bed),
              ),
              onChanged: (value) => _revisarValidacion(),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "Habitación imcompleta" : null,
            ),
            //IMPORTE
             TextFormField(
              controller: _controladorImporte,
              decoration: InputDecoration(
                labelText: "Importe Total(€)",
                icon: Icon(Icons.euro)
              ),
              onChanged: (value) => _revisarValidacion(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (v) => v!.isEmpty ? "Importe imcompleto" : null,
            ),
            SizedBox(height: 20,),
            //Estado
            DropdownButtonFormField(
              value: _estadoReserva,
              decoration: InputDecoration(
                labelText: "Estado"
              ),
              items: EstadoReserva.values.map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name.toUpperCase()))).toList(), 
              onChanged: (v) => setState(() => _estadoReserva = v!)
            ),
            SizedBox(height: 20,),
            //FECHA ENTRADA
            ListTile(
              title: Text("Fecha Entrada: ${_fechaInicio.day}/${_fechaInicio.month}/${_fechaInicio.year}"),
              trailing: Icon(Icons.calendar_today),
              onTap: ()=> _pedirFecha(true),
            ),
            //FECHA SALIDA
            ListTile(
              title: Text("Fecha Salida: ${_fechaFin.day}/${_fechaFin.month}/${_fechaFin.year}"),
              trailing: Icon(Icons.calendar_today),
              onTap: ()=> _pedirFecha(false),
            ),
            SizedBox(height: 30,),
            //BOTÓN GUARDADO
            GestureDetector(
              onTap: _guardar,
              child:AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  //El color cambia de gris a verde 
                  color: _esValido ? Colors.green : const Color.fromARGB(255, 108, 108, 108),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _esValido ? [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 10)] : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("GUARDAR", style: TextStyle(color: Colors.white),),
                  ],
                )),
            )
          ],
        ))
    );
  }
}