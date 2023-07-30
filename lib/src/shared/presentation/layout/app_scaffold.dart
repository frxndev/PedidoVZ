import 'package:flutter/material.dart';
import 'package:pedidosvz/src/shared/presentation/widgets/navigation_bar.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavigationBarWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, // Color del fondo del contenedor
                  border: Border.all(
                    color: Colors.black12, // Color del contorno
                    width: 2.0, // Grosor del contorno
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // Radio de los bordes
                ),
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
