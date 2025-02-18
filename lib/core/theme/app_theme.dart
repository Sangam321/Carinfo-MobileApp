import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat Regular',
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat Regular'),
                backgroundColor: const Color(0xFF390050),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ))),
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Color.fromARGB(255, 245, 238, 255),
            elevation: 4,
            shadowColor: Colors.black,
            titleTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }
}
