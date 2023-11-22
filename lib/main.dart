import 'package:arattai/screens/auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ArattaiApp());
}

class ArattaiApp extends StatelessWidget {
  const ArattaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 117, 221, 181)),
      ),
      home: AuthScreen(),
    );
  }
}
