// import 'package:chatwave/pages/login_page.dart';
import 'package:chatwave/auth/login_or_register_page.dart';
import 'package:chatwave/themes/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegisterPage(),
      theme: lightMode,
    );
  }
}
