import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'package:ecommerce_ui/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    delay(2);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    super.initState();
  }

  void delay(int sec) async {
    await Future.delayed(Duration(seconds: sec));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.amber),
          child: Text("Shopping\nApplication"),
        ),
      ),
    );
  }
}
