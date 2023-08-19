import 'package:mysql_client/mysql_client.dart';
import 'package:pedidosvz/src/shared/domain/services/load_config.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static MySQLConnection? _connection;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<MySQLConnection> getConnection() async {
    final config = await loadConfig();

    if (_connection == null) {
      _connection = await MySQLConnection.createConnection(
        host: config['host'],
        port: config['port'],
        userName: config['userName'],
        password: config['password'],
        databaseName: config['databaseName'],
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
