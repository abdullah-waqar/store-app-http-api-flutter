import 'package:flutter/material.dart';
import 'package:rest_api/screens/home.dart';
import 'package:rest_api/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rest api",
      home: LoginScreen(),
    );
  }
}
