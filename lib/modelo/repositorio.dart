import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'reserva.dart';

//Define un alias para el clousure usados en las búsquedas
typedef FiltroBusqueda = bool Function(Reserva);

//Clase Repositorio: Gestiona de la colección de objetos Reserva
class Repositorio {
  //Instancia privada única
  static final Repositorio _instancia = Repositorio._interno();
  //Constructor factory que devuelve siempre la lista cargada
  factory Repositorio(){
      return _instancia;
  }
  //Constructor nombreado privado que solo se ejecuta una vez
  Repositorio._interno(){
    if (_reservas.isEmpty) {
      agregarEjemplo();
    }
  }

  //Almacenamiento principal mediante una lista
  List<Reserva> _reservas = [];

  //Contador estático para asegurar que el código sea único para cada Reserva
  static int _ultimoCodigo = 0;

  //Getters y Setters
  List<Reserva> get reservas => _reservas;

  set reservas(List<Reserva> value) => _reservas = value;

  //Agrega una nueva reserva a la colección, verifica que la reserva no exista por código
  void agregar(Reserva reserva) {
    //Evita duplicar el código
    if (_reservas.any((r) => r.codigo == reserva.codigo)) {
      print("Ya existe la reserva con el código ${reserva.codigo}");
      return;
    }
    _reservas.add(reserva);
  }

  //Génera el código único incrementando el contador
  int generarCodigo() {
    _ultimoCodigo++;
    return _ultimoCodigo;
  }

  //Elimina una reserva por su código
  void eliminarPorCodigo(int codigo) {
    final longInicial = _reservas.length;

    _reservas.removeWhere((r) => r.codigo == codigo);

    if (_reservas.length < longInicial) {
      print("Reserva eliminada correctamente!");
    } else {
      print("Reserva no encontrada.");
    }
  }

  //Muestra todas las reservas. Se asegura que la lista no este vacía antes de iterear e imprimir.
  //Utiliza el método toString() de Reserva
  void listar() {
    if (_reservas.isNotEmpty) {
      for (Reserva r in _reservas) {
        print(r);
      }
    } else {
      print("No hay reservas guardadas.");
    }
  }

  //Actualiza una resreva con datos nuevos. Verifica que la resrva exista mediante el código y reemplaza
  // el objeto en esa posición
  void actualizar(Reserva nuevaReserva) {
    final indice = _reservas.indexWhere((r) => r.codigo == nuevaReserva.codigo);

    if (indice != -1) {
      _reservas[indice] = nuevaReserva;
      print("Reserva modificada correctamente!");
    } else {
      print("Reserva no encontrada.");
    }
  }

  //Inicializa la colección con datos de ejemplo, facilitando el testeo de la aplicación
  void agregarEjemplo() {
    _reservas.addAll([
      Reserva(
        codigo: generarCodigo(),
        cliente: 'Alexandro Bello',
        habitacion: 101,
        fechaInicio: DateTime(2026, 10, 10),
        fechaFin: DateTime(2026, 10, 15),
        estado: EstadoReserva.confirmada,
        importe: 350.0,
        icono: Icons.person
      ),
      Reserva(
        codigo: generarCodigo(),
        cliente: 'Gillermo Díaz',
        habitacion: 102,
        fechaInicio: DateTime(2025, 11, 1),
        fechaFin: DateTime(2025, 11, 3),
        estado: EstadoReserva.pendiente,
        importe: 200.0,
        icono: Icons.star
      ),
      Reserva(
        codigo: generarCodigo(),
        cliente: 'Noelia Freire',
        habitacion: 103,
        fechaInicio: DateTime(2026, 02, 14),
        fechaFin: DateTime(2026, 02, 18),
        estado: EstadoReserva.pendiente,
        importe: 560.9,
        icono: Icons.bed
      ),
      Reserva(
        codigo: generarCodigo(),
        cliente: 'Álvaro Ruíz',
        habitacion: 101,
        fechaInicio: DateTime(2026, 04, 3),
        fechaFin: DateTime(2025, 04, 21),
        estado: EstadoReserva.cancelada,
        importe: 2500.0,
        icono: Icons.person
      ),
      Reserva(
        codigo: generarCodigo(),
        cliente: 'Samuel de Luque',
        habitacion: 105,
        fechaInicio: DateTime(2026, 01, 02),
        fechaFin: DateTime(2026, 01, 02),
        estado: EstadoReserva.pendiente,
        importe: 777.0,
        icono: Icons.person
      ),
    ]);
    print("Datos añadidos correctamente!");
    listar();
  }

  //Busca empleando un clousure y utiliza el alias definido anteriormente
  List<Reserva> buscar(FiltroBusqueda criterio) {
    return _reservas.where(criterio).toList();
  }

  //Busca una reserva por código
  Reserva? buscarPorCodigo(int codigo) {
    try {
      return _reservas.firstWhere((r) => r.codigo == codigo);
    } catch (_) {
      return null;
    }
  }

  //Filtra las reservas con check-in en la fecha actual
  int contarCheckInHoy(){
    DateTime hoy = DateTime.now();
    return _reservas.where((r)=>
    r.fechaInicio.year == hoy.year &&
    r.fechaInicio.month == hoy.month &&
    r.fechaInicio.day == hoy.day).length;
  }
  //Filtra las reservas con check-out en la fecha actual
  int contarCheckOutHoy(){
    DateTime hoy = DateTime.now();
    return _reservas.where((r)=>
    r.fechaFin.year == hoy.year &&
    r.fechaFin.month == hoy.month &&
    r.fechaFin.day == hoy.day).length;
  }

  //Devuelve la lsita de reservas
  List<Reserva> obtenerTodas(){
    return _reservas;
  }
}
