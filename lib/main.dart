import 'package:flutter/material.dart';
import './expense.dart';

var kcolorscheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 51, 181));

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kcolorscheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kcolorscheme.onPrimaryContainer,
        foregroundColor: kcolorscheme.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: kcolorscheme.secondaryContainer
      )),
      cardTheme: const CardTheme().copyWith(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        color: kcolorscheme.secondaryContainer
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle().copyWith(
          fontSize: 17,
          fontWeight: FontWeight.bold,

          color:Colors.blue 
        )
      )
      
    ),
    
    home: const Expenses(),
  ));
}
