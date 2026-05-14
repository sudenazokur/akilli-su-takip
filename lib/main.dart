import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const SuTakipApp());
}

class SuTakipApp extends StatelessWidget {
  const SuTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akıllı Su Takip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}