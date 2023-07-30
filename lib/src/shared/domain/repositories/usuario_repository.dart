import 'package:pedidosvz/src/shared/domain/domain.dart';

class UsuarioRepository {
  Future<Usuario> register(Usuario usuario) async {
    final conn = await DatabaseService().getConnection();
    try {
      final result = await conn.execute(
        'INSERT INTO usuario (Nombre, Contrasenia) VALUES (:Nombre, :Contrasenia)',
        {
          "Nombre": usuario.nombre,
          "Contrasenia": usuario.contrasenia,
        },
      );
      return Usuario.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<Usuario> login(String nombre, String contrasenia) async {
    final conn = await DatabaseService().getConnection();
    try {
      final result = await conn.execute(
          'SELECT * FROM usuario WHERE Nombre = :Nombre AND Contrasenia = :Contrasenia',
          {
            "Nombre": nombre,
            "Contrasenia": contrasenia,
          });
      return Usuario.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }
}
