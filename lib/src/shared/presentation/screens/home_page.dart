import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pedidosvz/src/shared/config/config.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';
import 'package:pedidosvz/src/shared/presentation/providers/pedidos_provider.dart';
import 'package:pedidosvz/src/shared/presentation/widgets/widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    @override
    final lastOrder = PedidoRepository().getLastOrder();
    final listPedidos = ref.read(pedidoNotifierProvider);
    final allOrders = listPedidos.length;

    final cancelOrders =
        listPedidos.where((element) => element.idEstado == 3).length;
    final doneOrders =
        listPedidos.where((element) => element.idEstado == 2).length;
    final pendingOrders =
        listPedidos.where((element) => element.idEstado == 1).length;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Color(0xff6e7a85),
                ),
                children: [
                  TextSpan(text: 'Hola '),
                  TextSpan(
                    text: 'Trabajador, ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'bienvenido de nuevo!',
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 44,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'Estadisticas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardItem(
                          title: 'Total de\nPedidos',
                          value: allOrders,
                          color: const Color(0xff369eff),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CardItem(
                          title: 'Pedidos\nCancelados',
                          value: cancelOrders,
                          color: const Color(0xffff983a),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardItem(
                          title: 'Pedidos\nEntregados',
                          value: doneOrders,
                          color: const Color(0xff1bc943),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CardItem(
                          title: 'Pedidos\nPendientes',
                          value: pendingOrders,
                          color: const Color(0xffffd042),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 44,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Ultimo Pedido',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            return context.go('/orders');
                          },
                          child: const Text(
                            'Ver todos',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: lastOrder,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Pedido order = snapshot.data as Pedido;
                        return Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xfff7f7f7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pedido # ${order.idPedido}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      DateFormat.yMMMd()
                                          .format(order.createAt!),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff6e7a85),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cliente: ${order.nombreCliente}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 10.0,
                                ),
                                margin: const EdgeInsets.only(top: 5.0),
                                decoration: BoxDecoration(
                                  color: typeEstadoColor[order.idEstado],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  typeEstado[order.idEstado!],
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
