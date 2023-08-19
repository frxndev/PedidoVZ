import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> loadConfig() async {
  final file = File('assets/database_config.json');
  if (await file.exists()) {
    final contents = await file.readAsString();
    return json.decode(contents);
  } else {
    throw Exception("El archivo de configuración no existe.");
  }
}
