import 'package:flutter/material.dart';

import 'screens/todo_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        primaryColor: const Color(0xFF64B5F6),
        hintColor: const Color(0xFF2EECDC),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF37474F),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF37474F),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF37474F),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF64B5F6),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF64B5F6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: TodoListScreen(),
    );
  }
}
