import 'package:mysql_client/mysql_client.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static MySQLConnection? _connection;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<MySQLConnection> getConnection() async {
    if (_connection == null) {
      _connection = await MySQLConnection.createConnection(
        host: "127.0.0.1",
        port: 3306,
        userName: "pedidosvz",
        password: "virtual123",
        databaseName: "pedidosvz",
      );
      await _connection?.connect();
    }
    return _connection!;
  }

  Future<void> closeConnection() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }
  }
}
