import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/category_grid_item.dart';

import '../models/meal_model.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(MealModel meal) onToggleFavorites;
  final List<MealModel> availableMeals;
  
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorites,
    required this.availableMeals,
  });

  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meals: availableMeals,
          title: "Some Title!!",
          onToggleFavorites: onToggleFavorites,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: dummyMeals.length,
      itemBuilder: (context, index) {
        return CategoryGridItem(
          onTap: () {
            _selectCategory(context);
          },
          category: dummyCategories[index],
        );
      },
    );
  }
}
