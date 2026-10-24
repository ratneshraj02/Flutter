import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';

class Meals extends StatelessWidget {
  final List<MealModel> meals;
  final String title;
  const Meals({super.key, required this.meals, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Placeholder(),
    );
  }
}
