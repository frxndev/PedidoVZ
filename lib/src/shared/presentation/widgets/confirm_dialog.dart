import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmDialog extends ConsumerWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onCancelCallback,
    required this.onConfirmCallback,
  });

  final String title;
  final String content;
  final VoidCallback onCancelCallback;
  final VoidCallback onConfirmCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onConfirmCallback,
          child: const Text('Si'),
        ),
        TextButton(
          onPressed: onCancelCallback,
          child: const Text('No'),
        ),
      ],
    );
  }
}
