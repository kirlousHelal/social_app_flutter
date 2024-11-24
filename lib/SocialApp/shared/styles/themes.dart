import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme() => ThemeData(
    useMaterial3: false,
    colorScheme:
        ColorScheme.light(primary: defaultColor, onPrimary: Colors.white),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStatePropertyAll(
            BorderSide(color: Colors.grey[300] as Color)),
      ),
    ),
    appBarTheme: const AppBarTheme(
        // iconTheme: ,
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )));

ThemeData darkTheme() => ThemeData(
    // useMaterial3: false,
    colorScheme: ColorScheme.dark(primary: defaultColor),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStatePropertyAll(
            BorderSide(color: Colors.grey[300] as Color)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(defaultColor),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)))),
    )),
    appBarTheme: const AppBarTheme(
        color: Colors.black54,
        titleTextStyle: TextStyle(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black54,
          statusBarIconBrightness: Brightness.light,
        )));
