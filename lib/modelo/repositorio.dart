import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'reserva.dart';

//Define un alias para el clousure usados en las búsquedas
typedef FiltroBusqueda = bool Function(Reserva);

//Clase Repositorio: Gestiona de la colección de objetos Reserva
class Repositorio {
  //Almacenamiento principal mediante una lista
  static List<Reserva> _listaReservas = [];

  // Getter para acceder a la lista desde fuera
  List<Reserva> get reservas => _listaReservas;

  //Contador estático para asegurar que el código sea único para cada Reserva
  static int _ultimoCodigo = 0;

  //Agrega una nueva reserva a la colección, verifica que la reserva no exista por código
  void agregar(Reserva reserva) {
    //Evita duplicar el código
    if (_listaReservas.any((r) => r.codigo == reserva.codigo)) {
      print("Ya existe la reserva con el código ${reserva.codigo}");
      return;
    }
    _listaReservas.add(reserva);
  }

  //Génera el código único incrementando el contador
  String generarCodigo() {
    _ultimoCodigo++;
    return "0$_ultimoCodigo";
  }

  //Elimina una reserva por su código
  void eliminarPorCodigo(String codigo) {
    final longInicial = _listaReservas.length;

    _listaReservas.removeWhere((r) => r.codigo == codigo);

    if (_listaReservas.length < longInicial) {
      print("Reserva eliminada correctamente!");
    } else {
      print("Reserva no encontrada.");
    }
  }

  //Actualiza una resreva con datos nuevos. Verifica que la resrva exista mediante el código y reemplaza
  // el objeto en esa posición
  void actualizar(Reserva nuevaReserva) {
    final indice = _listaReservas.indexWhere((r) => r.codigo == nuevaReserva.codigo);

    if (indice != -1) {
      _listaReservas[indice] = nuevaReserva;
      print("Reserva modificada correctamente!");
    } else {
      print("Reserva no encontrada.");
    }
  }

  //Busca empleando un clousure y utiliza el alias definido anteriormente
  List<Reserva> buscarPorCliente(String cliente) {
    return _listaReservas.where((r) => r.cliente.toLowerCase().contains(cliente.toLowerCase())).toList();
  }

  //Busca una reserva por código
  Reserva? buscarPorCodigo(int codigo) {
    try {
      // Corregido: antes apuntaba a _reservas (inexistente)
      return _listaReservas.firstWhere((r) => r.codigo == codigo);
    } catch (_) {
      return null;
    }
  }

  //Filtra las reservas con check-in en la fecha actual
  int contarCheckInHoy(){
    DateTime hoy = DateTime.now();
    return _listaReservas.where((r)=>
    r.fechaInicio.year == hoy.year &&
    r.fechaInicio.month == hoy.month &&
    r.fechaInicio.day == hoy.day).length;
  }

  //Filtra las reservas con check-out en la fecha actual
  int contarCheckOutHoy(){
    DateTime hoy = DateTime.now();
    return _listaReservas.where((r)=>
    r.fechaFin.year == hoy.year &&
    r.fechaFin.month == hoy.month &&
    r.fechaFin.day == hoy.day).length;
  }

  //Devuelve la lsita de reservas
  List<Reserva> obtenerTodas()=> _listaReservas;

  //Método para cargar datos desde json
  Future<void> cargarReservasJson() async{
   try {
      // 1. Leer el archivo desde los assets
      final String respuesta = await rootBundle.loadString('assets/data/reservas.json');
      
      // 2. Decodificar el string a una lista dinámica
      final List<dynamic> data = json.decode(respuesta);

      // 3. Mapear cada elemento a un objeto Reserva y añadirlo a nuestra lista
      _listaReservas = data.map((jsonItem) => Reserva.fromJson(jsonItem)).toList();
      
      print("Reservas cargadas: ${_listaReservas.length}");
    } catch (e) {
      print("Error cargando reservas: $e");
    }
  }

  // Método estático para inicializar los datos
  Future<Repositorio> conDatosLocal() async {
    Repositorio instancia = Repositorio();
    await instancia.cargarReservasJson();
    return instancia;
  }
}