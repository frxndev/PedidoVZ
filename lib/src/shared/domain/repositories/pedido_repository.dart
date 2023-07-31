import 'package:pedidosvz/src/shared/config/config.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';

class PedidoRepository {
  Future<Pedido> create(Pedido pedido) async {
    final conn = await DatabaseService().getConnection();
    try {
      await conn.execute(
        'INSERT INTO pedidos (nombreCliente, telefonoCliente, descripcion)'
        'VALUES (:nombreCliente, :telefonoCliente, :descripcion)',
        {
          "nombreCliente": pedido.nombreCliente,
          "telefonoCliente": pedido.telefonoCliente,
          "descripcion": pedido.descripcion,
        },
      );

      final result = await conn.execute(
        'SELECT * FROM pedidos WHERE idPedido = LAST_INSERT_ID()',
      );
      return Pedido.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<Pedido> update(Pedido pedido) async {
    final conn = await DatabaseService().getConnection();
    try {
      await conn.execute(
        'UPDATE pedidos SET nombreCliente = :nombreCliente, telefonoCliente = :telefonoCliente, descripcion = :descripcion '
        'WHERE idPedido = :idPedido',
        {
          "nombreCliente": pedido.nombreCliente,
          "telefonoCliente": pedido.telefonoCliente,
          "descripcion": pedido.descripcion,
          "idPedido": pedido.idPedido,
        },
      );
      final result = await conn.execute(
        'SELECT * FROM pedidos WHERE idPedido = :idPedido',
        {
          "idPedido": pedido.idPedido,
        },
      );
      return Pedido.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<Pedido> cancel(int idPedido) async {
    final conn = await DatabaseService().getConnection();
    try {
      await conn.execute(
        'UPDATE pedidos SET idEstado = 3 WHERE idPedido = :idPedido',
        {
          "idPedido": idPedido,
        },
      );
      final result = await conn.execute(
        'SELECT * FROM pedidos WHERE idPedido = :idPedido',
        {
          "idPedido": idPedido,
        },
      );
      return Pedido.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<Pedido> entregrado(int idPedido) async {
    final conn = await DatabaseService().getConnection();
    try {
      await conn.execute(
        'UPDATE pedidos SET idEstado = 2 WHERE idPedido = :idPedido',
        {
          "idPedido": idPedido,
        },
      );
      final result = await conn.execute(
        'SELECT * FROM pedidos WHERE idPedido = :idPedido',
        {
          "idPedido": idPedido,
        },
      );
      return Pedido.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<Pedido> get(int idPedido) async {
    final conn = await DatabaseService().getConnection();
    try {
      final result = await conn.execute(
        'SELECT * FROM pedidos WHERE idPedido = :idPedido',
        {
          "idPedido": idPedido,
        },
      );
      return Pedido.fromMap(result.rows.first.assoc());
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<List<Pedido>> getAll() async {
    final conn = await DatabaseService().getConnection();
    try {
      final result =
          await conn.execute('SELECT * FROM pedidos ORDER BY createAt');
      return result.rows.map((row) => Pedido.fromMap(row.assoc())).toList();
    } finally {
      await DatabaseService().closeConnection();
    }
  }

  Future<List<Pedido>> search(String query) async {
    final conn = DatabaseService().getConnection();
    try {
      return conn.then((conn) async {
        final result = await conn.execute(
          'SELECT * FROM pedidos WHERE nombreCliente LIKE :query OR telefonoCliente LIKE :query OR descripcion LIKE :query ORDER BY createAt',
          {
            "query": '%$query%',
          },
        );
        return result.rows.map((row) => Pedido.fromMap(row.assoc())).toList();
      });
    } finally {
      DatabaseService().closeConnection();
    }
  }

  void sendedWhatsapp(Pedido pedido) async {
    final String body = '*Virtual Zone .Accesorios* \n\n '
        'Hola ${pedido.nombreCliente.toUpperCase()}, tu pedido (${pedido.descripcion.toUpperCase()}) está listo para ser entregado. '
        'Por favor, acércate a la tienda para retirarlo. \n\n'
        '_Gracias por tu preferencia_';

    final String url =
        'https://web.whatsapp.com/send?phone=52${pedido.telefonoCliente}&text=$body';

    openUrl(url: url);
  }
}


/*
SELECT p.idPedido, p.nombreCliente, p.telefonoCliente, p.descripcion, e.nombre AS estado, p.createAt, p.modifiedAt FROM pedidos p
INNER JOIN estados e
ON p.idEstado = e.idEstado
WHERE p.idEstado != 3
 */
