import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lo_form/lo_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedidosvz/src/shared/domain/domain.dart';
import 'package:pedidosvz/src/shared/presentation/providers/providers.dart';
import 'package:pedidosvz/src/shared/presentation/widgets/widgets.dart';

class AddPedidoModal extends ConsumerStatefulWidget {
  const AddPedidoModal({super.key, this.onStateChanged});

  final ValueChanged<LoFormState>? onStateChanged;

  @override
  AddPedidoModalState createState() => AddPedidoModalState();
}

class AddPedidoModalState extends ConsumerState<AddPedidoModal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 32, bottom: 18, left: 18, right: 18),
      child: LoForm<String>(
        onReady: widget.onStateChanged,
        onChanged: widget.onStateChanged,
        submittableWhen: (status) => status.isValid || status.isSubmitted,
        onSubmit: (values, setErrors) {
          if (values['nombre'] == null ||
              values['telefono'] == null ||
              values['descripcion'] == null) {
            return;
          }

          Pedido pedido = Pedido(
            nombreCliente: values['nombre'],
            telefonoCliente: values['telefono'],
            descripcion: values['descripcion'],
          );

          ref.read(pedidoNotifierProvider.notifier).create(pedido);
          context.pop(context);
        },
        builder: (form) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Nuevo Pedido',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              LoTextField(
                loKey: 'nombre',
                validators: [
                  LoRequiredValidator('Campo requerido'),
                  LoLengthValidator.min(3, 'Mínimo 3 caracteres')
                ],
                props: textFieldProps(hintText: 'Nombre', maxLength: 50),
              ),
              const SizedBox(height: 16),
              LoTextField(
                loKey: 'telefono',
                validators: [
                  LoRequiredValidator('Campo requerido'),
                  LoFieldValidator.any(
                    [
                      LoRegExpValidator(r'^[0-9]{10}$'),
                      LoRegExpValidator(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}$'),
                      LoRegExpValidator(r'^\([0-9]{3}\) [0-9]{3}-[0-9]{4}$'),
                    ],
                    'Numero telefónico invalido',
                  )
                ],
                props: textFieldProps(
                    hintText: 'Teléfono',
                    keyboardType: TextInputType.phone,
                    maxLength: 10),
              ),
              const SizedBox(height: 16),
              // descripcion pedido
              LoTextField(
                loKey: 'descripcion',
                validators: [
                  LoRequiredValidator('Campo requerido'),
                  LoLengthValidator.min(3, 'Mínimo 3 caracteres')
                ],
                props: textFieldProps(
                  hintText: 'Descripción del pedido',
                  minLines: 4,
                  maxLength: 250,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const Spacer(),
              FilledButton.tonal(
                onPressed: form.submit,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.only(top: 22, bottom: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      ),
    );
  }
}
