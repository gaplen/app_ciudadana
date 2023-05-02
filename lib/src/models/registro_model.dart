class Registro {
  final String nombre;
  final String correo;
  final String contrasena;

  Registro(
      {required this.nombre, required this.correo, required this.contrasena});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
    };
  }
}
