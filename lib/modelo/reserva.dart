import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum EstadoReserva { pendiente, confirmada, cancelada, finalizada }

//Clase Reserva: Modela una reserva de hotel con sus atributos y estado.
class Reserva {
  //Se establece como final para evitar modificaciones en el id de la reserva,
  // garantizando que cada reserva tenga un código único e inmutable una vez creada.
  final String _codigo;

  //Atributos privados que encapsulan los datos de la reserva
  String _cliente;
  int _habitacion;
  DateTime _fechaInicio;
  DateTime _fechaFin;
  EstadoReserva _estado;
  double _importe;
  IconData _icono;

  //Constructor con parámetros nombrados
  Reserva({
    required String codigo,
    required String? cliente,
    required int habitacion,
    required DateTime? fechaInicio,
    required DateTime? fechaFin,
    required EstadoReserva? estado,
    required double? importe,
    required IconData? icono,}
  ) : _codigo = codigo,
       _cliente = cliente ?? 'Desconocido',
       _habitacion = habitacion,
       _fechaInicio = fechaInicio ?? DateTime.now(),
       _fechaFin = fechaFin ?? DateTime.now().add(Duration(days: 1)),
       _estado = estado ?? EstadoReserva.pendiente,
       _importe = importe ?? 0.0,
       _icono = icono ?? Icons.person;

  factory Reserva.fromJson(Map<String, dynamic> json){
    return Reserva(
      codigo: json['codigo'], 
      cliente: json['cliente'], 
      habitacion: json['habitacion'], 
      fechaInicio: DateTime.parse(json['fechaInicio']) , 
      fechaFin: DateTime.parse(json['fechaFin']), 
      estado: EstadoReserva.values.firstWhere(
        (e) => e.name == json['estado']
      ), 
      importe: json['importe'].toDouble(), 
      icono: _mapIcon(json['icono']),);
  }

  static IconData _mapIcon(String iconName) {
    switch (iconName) {
      case 'star': return Icons.star;
      case 'bed': return Icons.bed;
      case 'hotel': return Icons.hotel;
      case 'beach_access': return Icons.beach_access;
      case 'family_restroom': return Icons.family_restroom;
      case 'business_center': return Icons.business_center;
      default: return Icons.person;
    }
  }
  
  //===GETTERS Y SETTERS===

  String get codigo => _codigo;

  String get cliente => _cliente;

  //Válida si el valor es nulo o vacío y establece un valor por defecto
  set cliente(String? value) {
    if (value == null || value.isEmpty) {
      _cliente = 'Desconocido';
    } else {
      _cliente = value;
    }
  }

  int get habitacion => _habitacion;

  //Válida si el valor es int y positivo, si no establece un valor por defecto
  set habitacion(dynamic value) {
    if (value is int && value > 0) {
      _habitacion = value;
    } else {
      _habitacion = 0;
    }
  }

  DateTime get fechaInicio => _fechaInicio;

  //Válida si el valor es anterior a la fechaFin
  set fechaInicio(DateTime value) {
    if (value.isAfter(_fechaFin)) {
      print("La fecha de inicio no puede ser posterior a la fecha de fin. ");
    } else {
      _fechaInicio = value;
    }
  }

  DateTime get fechaFin => _fechaFin;

  //Válida si el valor es posterior a la fechaInicio
  set fechaFin(DateTime value) {
    if (value.isBefore(_fechaInicio)) {
      print("La fecha de fin no puede ser anterior a la fecha de inicio. ");
    } else {
      _fechaFin = value;
    }
  }

  EstadoReserva get estado => _estado;

  //Válida si el valor esta dentro de la enumeración de estados
  set estado(value) {
    if (value is EstadoReserva) {
      _estado = value;
    } else {
      _estado=EstadoReserva.pendiente;
      print("Estado inválido. Establece pendiente por defecto");
    }
  }

  double get importe => _importe;

  //Válida si el valor es double y positivo, si no establece valor por defecto
  set importe(dynamic value) {
    if (value is double && value >= 0) {
      _importe = value;
    } else {
      _importe = 0;
      print("Valor de importe inválido. Establece 0 por defecto");
    }
  }

  set icono(IconData value) => _icono = value;

  IconData get icono => _icono;
  
  //Representación de Reserva
  @override
  String toString() {
    return 'Código: $_codigo | Cliente: $_cliente | Habitación: $_habitacion | '
        'Inicio: ${_fechaInicio.toLocal().toString().split(" ")[0]} | '
        'Fin: ${_fechaFin.toLocal().toString().split(" ")[0]} | '
        'Estado: ${_estado.name} | Importe: €$_importe';
  }

  //Permite la comparación de reservas por su código, crucial para operaciones de búsqueda y eliminación
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Reserva &&
          runtimeType == other.runtimeType &&
          _codigo == other._codigo;

  @override
  int get hashCode => _codigo.hashCode;
}
