import 'package:ecommerce_ui/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EcommerceApp());
}


class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}