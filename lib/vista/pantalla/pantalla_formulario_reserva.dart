import 'package:flutter/material.dart';
import 'package:xestion_reservas_hotel/modelo/reserva.dart';
import 'package:xestion_reservas_hotel/modelo/repositorio.dart';

class PantallaFormularioReserva extends StatefulWidget {
  //Variable para controlar si se trata de formulario de creación o de modificación
  //En formulario de modificación, se consultan los campos de la reserva que se pasa
  final Reserva? reserva;

  const PantallaFormularioReserva({super.key, this.reserva});

  @override
  State<PantallaFormularioReserva> createState() => _PantallaFormularioReservaState();
}

class _PantallaFormularioReservaState extends State<PantallaFormularioReserva> {
  //Llave global para validar
  final _formLlave = GlobalKey<FormState>();
  
  //Controladores para los campos textuales del formulario
  final _controladorCliente = TextEditingController();
  final _controladorHabitacion = TextEditingController();
  final _controladorImporte = TextEditingController();

  //Variables para controlar datos no textuales
  EstadoReserva _estadoReserva = EstadoReserva.pendiente; //Estado por defecto
  DateTime _fechaInicio = DateTime.now(); // Fecha por defecto
  DateTime _fechaFin = DateTime.now(); //Fecha por defecto
  IconData _icono = Icons.person; //Icono por defecto

  //Variable para comprobar validez del formulario, para cambio de color del botón de guardado
  bool _esValido = false;

  //Lista de iconos disponibles para la selección
  final List<IconData> _iconosDisponibles = [
    Icons.hotel,
    Icons.beach_access,
    Icons.bed,
    Icons.family_restroom,
    Icons.business_center,
    Icons.star
  ];

  //Método dispose
  void dispose(){
    _controladorCliente.dispose();
    _controladorHabitacion.dispose();
    _controladorImporte.dispose();
    super.dispose();
  }

  //Función para seleccion de fecha
  //Muestra un calendario desde el año de firstDate hasta el de lastDate
  void _pedirFecha(bool esInicio) async{ //Debe ser async para que espera a que el usuario seleccione la fecha
    DateTime? seleccion = await showDatePicker(
      context: context, 
      firstDate: DateTime(2024), // Año de inicio del calendario
      lastDate: DateTime(2030) //Año límite del calendario
    );

    //Verifica la selección de una fecha
    if (seleccion != null) {
      setState(() {
        if (esInicio) { 
          _fechaInicio = seleccion; //Establece la fecha de inicio
        }else{
          _fechaFin = seleccion; //Establece la fecha de salida
        }
      });
    }
  }

  //Función para mostrar las opciones de iconos
  void _mostrarIcono(){
    showDialog( //Muestra un contenedor
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Selecciona un icono"), //Título del contenedor
          content: SizedBox(
            width: double.maxFinite, 
            child: GridView.builder( // Divide el contenedor en cuadricula
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: _iconosDisponibles.length, //Cantidad de items en la cuadricula según el total de iconos disponibles
              itemBuilder: (context,indice){ //Establece en cada cuadricula un icono de la lista según indice
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _icono = _iconosDisponibles[indice]; //Establece como icono de la reserva el icono seleccionado
                    });
                    Navigator.pop(context); //Vuelve a la pantalla formulario
                  }, 
                  icon: Icon(_iconosDisponibles[indice], //Muestra en cada cuadricula el icono según inidice
                  size: 35, //Tamaño icono
                  color: Colors.green, //Color icono
                  )
                );
              },
            ),
          ),
        );
      }
    );
  }

  //Función para mostrar datos de la reserva pasada en caso de modificación
  void initState(){
    super.initState();
    if(widget.reserva != null){
      _controladorCliente.text = widget.reserva!.cliente; //Nombre cliente
      _controladorHabitacion.text = widget.reserva!.habitacion.toString(); //Número de habitación
      _controladorImporte.text = widget.reserva!.importe.toString(); //Importe
      _fechaInicio = widget.reserva!.fechaInicio; //Fecha de entrada
      _fechaFin = widget.reserva!.fechaFin; //Fecha de salida
      _estadoReserva = widget.reserva!.estado; //Estado de la reserva
      _icono = widget.reserva!.icono; //Icono de la reserva
    }
    //Validación para cambio de color en el botón
    _revisarValidacion();
  }

  //Función para guardar la reserva en el repositorio
  void _guardar(){
    if (_formLlave.currentState!.validate()) { //Verifica que el formulario este completo y sea válido
      if (widget.reserva == null) {
        //FORMULARIO CREAR: Creamos una reserva nueva
        Reserva nueva = Reserva( 
          codigo: Repositorio().generarCodigo(), 
          cliente: _controladorCliente.text, 
          habitacion: int.parse(_controladorHabitacion.text), 
          fechaInicio: _fechaInicio, 
          fechaFin: _fechaFin, 
          estado: _estadoReserva, 
          importe: double.parse(_controladorImporte.text),
          icono: _icono);

        Repositorio().agregar(nueva); //Añadimos la nueva reserva al repositorio
      }else{
        //FORMULARIO MODIFICAR: El código se mantiene y modificamos los datos si procede
        widget.reserva!.cliente = _controladorCliente.text;
        widget.reserva!.habitacion = int.parse(_controladorHabitacion.text);
        widget.reserva!.importe = double.parse(_controladorImporte.text);
        widget.reserva!.fechaInicio = _fechaInicio;
        widget.reserva!.fechaFin = _fechaFin;
        widget.reserva!.estado = _estadoReserva;
        widget.reserva!.icono = _icono;
      }
      Navigator.pop(context); //Regresa a la pantalla del listado o detalle reserva
    }
  }

  //Función para validar cada vez que el usuario escribe un campo del formulario
  void _revisarValidacion(){
    setState(() {
      bool nombreOk = _controladorCliente.text.isNotEmpty; //Verifica que el campo del nombre no está vácio
      bool habitacionOk = _controladorHabitacion.text.isNotEmpty; //Verifica que el campo de la habitación no está vácio
      bool importeOk = double.tryParse(_controladorImporte.text) != null; //Verifica que el campo del importe no está vácio

      //Si todos los campos están correctos establece _esValido en true
      _esValido = nombreOk && habitacionOk && importeOk;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.reserva == null ? "Nueva Reserva" : "Editar Reserva"),), //Titulo de la página según el tipo de formulario
      body: Form(
        key: _formLlave, //Llave formulario
        child: ListView( //Lista para organizar el formulario
          padding: EdgeInsets.all(20),
          children: [
            //ICONO Centrado
            Center(
              child: Column(
                children: [
                  GestureDetector( //Detecta el toque para abrir el contenedor de los iconos disponibles
                    onTap: _mostrarIcono,
                    child: CircleAvatar( //Da formato circular para el icono
                      radius: 50,
                      backgroundColor: Colors.white, 
                      child: Icon(_icono, size: 50, color: Colors.green,), //Icono de tamaño grande
                    ),
                  ),
                  SizedBox(height: 8,)
                ],
              ),
            ),
            SizedBox(height: 30,), //Espacio entre icono y formulario
            //CLIENTE
            TextFormField( //Elemento del formulario 
              controller: _controladorCliente,
              decoration: InputDecoration(
                labelText: "Nombre Cliente", //Etiqueta explicativa
                icon: Icon(Icons.person) //Icono representativo
              ),
              onChanged: (value) => _revisarValidacion(), //Cada vez que se modifica se valida
              validator: (v) => v!.isEmpty ? "Nombre imcompleto" : null, // Si esta en blanco muestra un aviso 
            ),
            //HABITACIÓN
             TextFormField( //Elemento del formulario 
              controller: _controladorHabitacion,
              decoration: InputDecoration(
                labelText: "Habitacion", //Etiqueta explicativa
                icon: Icon(Icons.bed), //Icono representativo
              ),
              onChanged: (value) => _revisarValidacion(), //Cada vez que se modifica se valida
              keyboardType: TextInputType.number, //Establece el tipo de teclado a mostrar - Númerico
              validator: (v) => v!.isEmpty ? "Habitación imcompleta" : null, // Si esta en blanco muestra un aviso 
            ),
            //IMPORTE
             TextFormField( //Elemento del formulario 
              controller: _controladorImporte,
              decoration: InputDecoration(
                labelText: "Importe Total(€)", //Etiqueta explicativa
                icon: Icon(Icons.euro) //Icono representativo
              ),
              onChanged: (value) => _revisarValidacion(), //Cada vez que se modifica se valida
              keyboardType: TextInputType.numberWithOptions(decimal: true), //Establece el tipo de teclado a mostrar - Númerico que permite decimales
              validator: (v) => v!.isEmpty ? "Importe imcompleto" : null, //Icono representativo
            ),
            SizedBox(height: 20,), //Espacio entre campos textuales y de selección
            //Estado
            DropdownButtonFormField( //Muestra menú desplegable con los estados posibles
              value: _estadoReserva, //Valor por defecto
              decoration: InputDecoration(
                labelText: "Estado" //Etiqueta explicativa
              ),
              items: EstadoReserva.values.map((e) => DropdownMenuItem( //Establece en el menú cada estado disponible
                value: e,
                child: Text(e.name.toUpperCase()))).toList(), 
              onChanged: (v) => setState(() => _estadoReserva = v!) //Al seleccionar establece el estado de la reserva con el seleccionado
            ),
            SizedBox(height: 20,), //Espacio para los campos de fecha
            //FECHA ENTRADA
            ListTile( // Fila de la lista
              title: Text("Fecha Entrada: ${_fechaInicio.day}/${_fechaInicio.month}/${_fechaInicio.year}"), //Etiqueta explicativa con fecha por defecto
              trailing: Icon(Icons.calendar_today), //Icono representativo
              onTap: ()=> _pedirFecha(true), //Muestra el calendario y establece la fecha inicial
            ),
            //FECHA SALIDA
            ListTile( // Fila de la lista
              title: Text("Fecha Salida: ${_fechaFin.day}/${_fechaFin.month}/${_fechaFin.year}"), //Etiqueta explicativa con fecha por defecto
              trailing: Icon(Icons.calendar_today), //Icono representativo
              onTap: ()=> _pedirFecha(false), //Muestra el calendario y establece la fecha inicial
            ),
            SizedBox(height: 30,), //Espacio entre el formulario y el botón de guardado
            //BOTÓN GUARDADO
            GestureDetector( //Se usa un detector de gestos para darle animación al botón
              onTap: _guardar, //Al pulsar guarda/actualiza la reserva
              child:AnimatedContainer( 
                duration: Duration(milliseconds: 500), //Duración de la animación
                curve: Curves.easeInOut, //La animación comienza despacio, luego acelera y termina despacio
                height: 55, //Altura del contenedor
                alignment: Alignment.center, //Centrado en la pantalla
                decoration: BoxDecoration(
                  //El color cambia de gris a verde 
                  color: _esValido ? Colors.green : const Color.fromARGB(255, 108, 108, 108), //Si el formulario es válido pasa a verde, si no se mantiene gris
                  borderRadius: BorderRadius.circular(10), //Forma redondeada
                  boxShadow: _esValido ? [BoxShadow(color: Colors.green.withOpacity(0.4), blurRadius: 10)] : [], //Si el formulario es válido el contendor tendrá sombreado
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Hijo centrado en el contenedor
                  children: [
                    Text("GUARDAR", style: TextStyle(color: Colors.white),), //Texto explicativo
                  ],
                )),
            )
          ],
        ))
    );
  }
}