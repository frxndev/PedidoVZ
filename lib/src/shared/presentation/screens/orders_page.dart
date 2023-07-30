import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                        child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white,
                            height: size.height * 0.6,
                            width: size.width * 0.4,
                            padding: const EdgeInsets.all(8),
                            child: const AddPedidoModal(),
                          ),
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
      ],
    );
  }
}
