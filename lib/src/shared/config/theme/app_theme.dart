import 'package:flutter/material.dart';

// const seedColor = Color.fromARGB(255, 7, 80, 59);
const seedColor = Colors.orange;

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        colorSchemeSeed: seedColor,
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
      );
}
