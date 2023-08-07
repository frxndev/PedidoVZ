import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';

class PedidoNotifier extends StateNotifier<List<Pedido>> {
  final PedidoRepository _repository;

  PedidoNotifier(this._repository) : super([]);

  Future<void> getAll() async {
    state = await _repository.getAll();
  }

  Future<void> create(Pedido pedido) async {
    final createdPedido = await _repository.create(pedido);
    state = [...state, createdPedido];
  }

  Future<void> update(Pedido pedido) async {
    final updatedPedido = await _repository.update(pedido);
    state = [
      for (final pedido in state)
        if (pedido.idPedido == updatedPedido.idPedido) updatedPedido else pedido
    ];
  }

  Future<void> cancel(int idPedido) async {
    final canceledPedido = await _repository.cancel(idPedido);
    state = [
      for (final pedido in state)
        if (pedido.idPedido == canceledPedido.idPedido)
          canceledPedido
        else
          pedido
    ];
  }

  Future<void> entregrado(int idPedido) async {
    final deliveredPedido = await _repository.entregrado(idPedido);
    state = [
      for (final pedido in state)
        if (pedido.idPedido == deliveredPedido.idPedido)
          deliveredPedido
        else
          pedido
    ];
  }

  // Search filter
  Future<void> search(String query) async {
    state = await _repository.search(query);
  }
}

final pedidoProvider = Provider((ref) => PedidoRepository());

final pedidoNotifierProvider =
    StateNotifierProvider<PedidoNotifier, List<Pedido>>((ref) {
  return PedidoNotifier(PedidoRepository());
});

final filteredPedidoProvider = Provider<List<Pedido>>((ref) {
  final allPedidos = ref.watch(pedidoNotifierProvider);
  final pedidosFiltrados =
      allPedidos.where((pedido) => pedido.idEstado == 1).toList();
  return pedidosFiltrados;
});
