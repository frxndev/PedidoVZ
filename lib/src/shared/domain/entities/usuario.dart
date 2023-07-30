class Usuario {
  String id;
  String nombre;
  String contrasenia;

  Usuario({
    required this.id,
    required this.nombre,
    required this.contrasenia,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['Id'],
      nombre: map['Nombre'],
      contrasenia: map['Contrasenia'],
    );
  }
}
