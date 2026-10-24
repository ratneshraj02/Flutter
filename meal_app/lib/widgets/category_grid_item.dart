import 'package:flutter/material.dart';
import 'package:meal_app/models/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  final CategoryModel category;
  const CategoryGridItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [category.color.withAlpha(55), category.color.withAlpha(90)],
          ),
        ),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
