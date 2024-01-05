import 'package:uuid/uuid.dart';

var uuid = const Uuid();

enum Categoria {
  verdura,
  fruta,
  lacteos,
  carne,
}

class Producto {
  Producto({
    required this.nombre,
    required this.cantidad,
    required this.categoria,
  }) : id = uuid.v4();

  final String id;
  final String nombre;
  final int cantidad;
  final Categoria categoria;
}
