import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedidosvz/src/shared/presentation/providers/providers.dart';
import 'package:pedidosvz/src/shared/presentation/widgets/widgets.dart';

class PedidosList extends ConsumerStatefulWidget {
  const PedidosList({super.key});

  @override
  PedidosListState createState() => PedidosListState();
}

class PedidosListState extends ConsumerState<PedidosList> {
  @override
  void initState() {
    // Llamada inicial para obtener los datos
    ref.read(pedidoNotifierProvider.notifier).getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Utiliza ref.watch para que el widget escuche los cambios en el estado
    final pedidos = ref.watch(filteredPedidoProvider);

    return ListView.builder(
      itemCount: pedidos.length,
      itemBuilder: (context, index) {
        final pedido = pedidos[index];

        return PedidoListTile(
          onTapCallback: () {
            if (pedido.idEstado != 3 && pedido.idEstado != 2) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return PedidoModalSheet(pedido);
                },
              );
            }
          },
          pedido: pedido,
        );
      },
    );
  }
}





/*

pedidosList.when(
      data: (pedidos) {
        return ListView.builder(
          itemCount: pedidos.length,
          itemBuilder: (context, index) {
            final pedido = pedidos[index];
            return PedidoListTile(
              onTapCallback: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PedidoModalSheet(pedido);
                  },
                );
              },
              pedido: pedido,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error loading orders: $error'),
    );

*/
