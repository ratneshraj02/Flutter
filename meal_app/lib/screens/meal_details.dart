import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetails extends StatelessWidget {
  final MealModel meal;
  const MealDetails({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(meal.title, style: TextStyle(fontSize: 16))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(meal.imageUrl, height: 300, width: double.infinity, fit: BoxFit.cover),
              const SizedBox(height: 15),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              for (final ingredients in meal.ingredients) Text(ingredients),
              const SizedBox(height: 24),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Text(step, textAlign: TextAlign.center),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
