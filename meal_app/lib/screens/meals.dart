import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/screens/meal_details.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealScreen extends StatelessWidget {
  final List<MealModel> meals;
  final String? title;
  const MealScreen({super.key, required this.meals, this.title});

  void selectMeal(BuildContext context, MealModel meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetails(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh  oh.... nothing here!",
            style: Theme.of(context).textTheme.headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          Text(
            "Try select different category",
            style: Theme.of(context).textTheme.bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: meals[index],
            onSelectMeal: (meal) {
              selectMeal(context, meal);
            },
          );
        },
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
