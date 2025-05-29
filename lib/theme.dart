import 'package:flutter/material.dart';

// Cole aqui a definição completa do seu ThemeData
final ThemeData temaFilmesDark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[300]!,
    onPrimary: Colors.black,
    secondary: Colors.grey[600]!,
    onSecondary: Colors.white,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.grey[200]!,
    background: Color(0xFF121212),
    onBackground: Colors.grey[200]!,
    error: Colors.redAccent[200]!,
    onError: Colors.black,
  ),
  scaffoldBackgroundColor: Color(0xFF121212),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A),
    foregroundColor: Colors.grey[200],
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.grey[100],
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
  cardTheme: CardTheme(
    color: Color(0xFF1E1E1E),
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  textTheme: TextTheme(
    // ... (resto do seu textTheme)
    displayLarge: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.grey[300], fontSize: 16),
  ).apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.grey[100],
  ),
  inputDecorationTheme: InputDecorationTheme(
    // ... (resto do seu inputDecorationTheme)
    filled: true,
    fillColor: Colors.grey[800]?.withOpacity(0.5),
    hintStyle: TextStyle(color: Colors.grey[500]),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    // ... (resto do seu elevatedButtonTheme)
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      foregroundColor: Colors.black,
    ),
  ),
  // ... (outras customizações do tema)
);

// Você também pode definir o tema claro aqui, se tiver um
// final ThemeData temaFilmesLight = ThemeData( ... );