import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pedidosvz/src/shared/config/config.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';
import 'package:pedidosvz/src/shared/presentation/modals/modals.dart';
import 'package:pedidosvz/src/shared/presentation/providers/providers.dart';

class PedidoModalSheet extends ConsumerWidget {
  const PedidoModalSheet(this.pedido, {super.key});

  final Pedido pedido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PedidoRepository pedidoRepository = PedidoRepository();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.60,
      child: FractionallySizedBox(
        heightFactor:
            0.7, // Ajusta la altura de la hoja modal según tus necesidades
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                '#${pedido.idPedido} ${pedido.descripcion}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit_document),
                title: const Text('Modificar pedido'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SingleChildScrollView(
                            child: Container(
                              height: size.height * 0.9,
                              width: size.width * 0.4,
                              padding: const EdgeInsets.all(8),
                              child: UpdatePedidoModal(pedido: pedido),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.whatsappIcon,
                  height: 22,
                ),
                title: const Text('Avisar por WhatsApp'),
                onTap: () {
                  pedidoRepository.sendedWhatsapp(pedido);
                  context.pop(context);
                },
              ),
              if (pedido.idEstado == 1)
                ListTile(
                  leading: const Icon(Icons.done_all_rounded),
                  title: const Text('Pedido entregado'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Pedido entregado'),
                          content: const Text(
                              '¿Estás seguro de marcar el pedido como entregado?'),
                          actions: <Widget>[
                            FloatingActionButton(
                              onPressed: () =>
                                  context.pop(context), // Closes the dialog
                              child: const Text('No'),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                ref
                                    .read(pedidoNotifierProvider.notifier)
                                    .entregrado(pedido.idPedido!);
                                context.pop(context);
                                context.pop(context);
                              },
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                              child: const Text('Si'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ListTile(
                leading: const Icon(Icons.edit_document),
                title: const Text('Cancelar pedido'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                            Text('Cancelar pedido de ${pedido.nombreCliente}'),
                        content: const Text(
                            'Esta acción no se puede deshacer, ¿Estás seguro de cancelar el pedido? '),
                        actions: <Widget>[
                          FloatingActionButton(
                            onPressed: () =>
                                context.pop(context), // Closes the dialog
                            child: const Text('No'),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              ref
                                  .read(pedidoNotifierProvider.notifier)
                                  .cancel(pedido.idPedido!);
                              context.pop(context);
                              context.pop(context);
                            },
                            backgroundColor:
                                Theme.of(context).colorScheme.errorContainer,
                            child: const Text('Si'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
