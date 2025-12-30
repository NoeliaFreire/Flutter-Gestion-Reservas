import 'reserva.dart';

//Define un alias para el clousure usados en las búsquedas
typedef FiltroBusqueda = bool Function(Reserva);

//Clase Repositorio: Gestiona de la colección de objetos Reserva
class Repositorio {
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
        fechaInicio: DateTime(2025, 10, 10),
        fechaFin: DateTime(2025, 10, 15),
        estado: EstadoReserva.confirmada,
        importe: 350.0,
      ),
      Reserva(
        codigo: generarCodigo(),
        cliente: 'Noa Ladra',
        habitacion: 102,
        fechaInicio: DateTime(2025, 11, 1),
        fechaFin: DateTime(2025, 11, 3),
        estado: EstadoReserva.pendiente,
        importe: 200.0,
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
}
