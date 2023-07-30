class Pedido {
  int? idPedido;
  String nombreCliente;
  String telefonoCliente;
  String descripcion;
  int? idEstado;
  DateTime? createAt;
  DateTime? modifiedAt;

  Pedido({
    this.idPedido,
    required this.nombreCliente,
    required this.telefonoCliente,
    required this.descripcion,
    this.idEstado,
    this.createAt,
    this.modifiedAt,
  });

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      idPedido: int.parse(map['idPedido']),
      nombreCliente: map['nombreCliente'],
      telefonoCliente: map['telefonoCliente'],
      descripcion: map['descripcion'],
      idEstado: int.parse(map['idEstado']),
      createAt:
          (map['createAt'] != null) ? DateTime.parse(map['createAt']) : null,
    );
  }

  Pedido copyWith({
    int? idPedido,
    String? nombreCliente,
    String? telefonoCliente,
    String? descripcion,
    int? idEstado,
    DateTime? createAt,
    DateTime? modifiedAt,
  }) {
    return Pedido(
      idPedido: idPedido ?? this.idPedido,
      nombreCliente: nombreCliente ?? this.nombreCliente,
      telefonoCliente: telefonoCliente ?? this.telefonoCliente,
      descripcion: descripcion ?? this.descripcion,
      idEstado: idEstado ?? this.idEstado,
      createAt: createAt ?? this.createAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
