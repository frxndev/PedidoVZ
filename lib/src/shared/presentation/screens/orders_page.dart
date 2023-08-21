import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';
import 'package:pedidosvz/src/shared/presentation/modals/modals.dart';
import 'package:pedidosvz/src/shared/presentation/providers/providers.dart';
import 'package:pedidosvz/src/shared/presentation/widgets/widgets.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.white,
                          height: size.height * 0.9,
                          width: size.width * 0.4,
                          padding: const EdgeInsets.all(8),
                          child: const AddPedidoModal(),
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 22,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Nuevo Pedido'),
            ),
            const Spacer(),
            SearchBar(
              hintText: "Buscar pedido",
              width: size.width * 0.2,
              onSearchCallback: (value) =>
                  ref.read(pedidoNotifierProvider.notifier).search(value),
            ),
            // Create search bar
          ],
        ),
        const SizedBox(height: 20),
        const Expanded(child: PedidosList()),
        const SizedBox(height: 20),
        FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmDialog(
                  title: 'Generar Reporte',
                  content: '¿Está seguro que desea generar el reporte?',
                  onCancelCallback: () => context.pop(context),
                  onConfirmCallback: () {
                    _onGenerateExcelButtonPressed(ref, context);
                    context.pop(context);
                  },
                );
              },
            );
          },
          label: const Text('Generar Reporte'),
        ),
      ],
    );
  }

  void _onGenerateExcelButtonPressed(WidgetRef ref, BuildContext context) {
    try {
      generateExcel(ref.read(filteredPedidoProvider));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Reporte generado y guardado correctamente!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error al generar el reporte: $e',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
