import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/screens/profile.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInitialFilter = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<MealModel> _favoritesMeals = [];
  Map<Filters, bool> _selectedFilters = kInitialFilter;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(seconds: 3), content: Text(message)),
    );
  }

  void _toggleMealFavoritesState(MealModel meal) {
    final isExisting = _favoritesMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoritesMeals.remove(meal);
      });
      _showInfoMessage("Meal is no longer is favorite.");
    } else {
      setState(() {
        _favoritesMeals.add(meal);
      });
      _showInfoMessage("Marked as Favorite");
    }
  }

  void selectPage(int idx) {
    setState(() {
      _selectedPageIndex = idx;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (context) => FilterScreen(currentFilter: kInitialFilter),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! == !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters[Filters.lactoseFree]! == !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters[Filters.vegetarian]! == !meal.isVegetarian) {
        return false;
      }

      if (_selectedFilters[Filters.vegan]! == !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      onToggleFavorites: _toggleMealFavoritesState,
      availableMeals: availableMeals,
    );
    String activePageTitle = "Categories Screen";

    if (_selectedPageIndex == 1) {
      activeScreen = MealScreen(
        meals: _favoritesMeals,
        onToggleFavorites: _toggleMealFavoritesState,
      );
      activePageTitle = "Your Favorites";
    }

    if (_selectedPageIndex == 2) {
      activeScreen = ProfileScreen();
      activePageTitle = "Profile Screen";
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Category",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.start), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: selectPage,
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
    );
  }
}
