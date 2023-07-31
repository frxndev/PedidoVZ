import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';
import 'package:uuid/uuid.dart';

Future<void> generateExcel(List<Pedido> pedidos) async {
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];

  // Escribir encabezados
  sheet.appendRow([
    'Numero Pedido',
    'Nombre Cliente',
    'Teléfono Cliente',
    'Descripción',
    'Fecha de Creación'
  ]);

  // Escribir datos
  for (var pedido in pedidos) {
    sheet.appendRow([
      pedido.idPedido.toString(),
      pedido.nombreCliente,
      pedido.telefonoCliente,
      pedido.descripcion,
      pedido.createAt != null ? pedido.createAt.toString() : '',
    ]);
  }

  // Generate the file name with UUID and current date
  const uuid = Uuid();
  final now = DateTime.now();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final fileName = "${dateFormat.format(now)}_pedidos_${uuid.v4()}.xlsx";

  // Get the desktop directory path
  final desktopDir = getDesktopDirectory();

  // Create the "reportePedidos" folder if it doesn't exist
  final reportePedidosDir = Directory(p.join(desktopDir, "reportePedidos"));
  if (!await reportePedidosDir.exists()) {
    await reportePedidosDir.create(recursive: true);
  }

  // Combine the desktop directory with the file name to get the full file path
  final filePath = p.join(reportePedidosDir.path, fileName);

  // Save the file
  final file = File(filePath);
  final bytes = excel.save(fileName: fileName) ?? [];
  await file.writeAsBytes(bytes);
}

String getDesktopDirectory() {
  if (Platform.isMacOS) {
    return p.join("/Users", Platform.environment['USER'], "Desktop");
  } else if (Platform.isWindows) {
    return p.join(Platform.environment['USERPROFILE']!, "Desktop");
  } else if (Platform.isLinux) {
    return p.join(Platform.environment['HOME']!, "Desktop");
  } else {
    throw UnsupportedError("Desktop path not supported on this platform");
  }
}
