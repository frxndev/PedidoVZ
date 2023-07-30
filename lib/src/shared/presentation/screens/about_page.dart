import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Sistema de pedidos Virtual Zone .Acesorios',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Desarrollado por: ',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Ing. Francisco Josue Huchin Uc',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
