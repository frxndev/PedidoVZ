import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedidosvz/src/shared/config/config.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';

class PedidoListTile extends StatelessWidget {
  const PedidoListTile({
    super.key,
    required this.onTapCallback,
    required this.pedido,
  });

  final Pedido pedido;
  final VoidCallback onTapCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .onSecondaryContainer
              .withOpacity(0.04),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        mouseCursor: pedido.idEstado == 3 || pedido.idEstado == 2
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        hoverColor: Colors.black12,
        onTap: onTapCallback,
        title: Text(
          pedido.descripcion,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pedido.nombreCliente,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: typeEstadoColor[pedido.idEstado],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                typeEstado[pedido.idEstado!],
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        trailing: Text(
          DateFormat.yMMMd().format(pedido.createAt!),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
