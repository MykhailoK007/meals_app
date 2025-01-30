import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/main_drawer.dart';
import 'package:meals_app/models/filter_item.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

const Map<FilterId, bool> initialFilters = {
  FilterId.glutenFree: false,
  FilterId.lactoseFree: false,
  FilterId.vegetarian: false,
  FilterId.vegan: false
};

class _TabsState extends State<Tabs> {
  int _selectedTabIndex = 0;
  final List<Meal> _favorites = [];
  Map<FilterId, bool> _selectedFilters = initialFilters;

  void toggleFavoriteMeal(Meal meal) {
    final isExisting = _favorites.contains(meal);
    if (isExisting) {
      _favorites.remove(meal);
      _showInfoMessage('Meal removed from favorites');
    } else {
      _favorites.add(meal);
      _showInfoMessage('Meal added to favorites');
    }
  }

  void _selectTab(int tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(String identifier) async {
    final navigatorWithContext = Navigator.of(context);
    navigatorWithContext.pop();
    if (identifier == 'filters') {
      final result = await navigatorWithContext.push<Map<FilterId, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      print(result);
      setState(() {
        _selectedFilters = result ?? initialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[FilterId.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[FilterId.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[FilterId.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[FilterId.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget content = CategoriesScreen(
        onToggleFavorite: toggleFavoriteMeal, availableMeals: availableMeals);
    String pageTitle = 'Categories';
    if (_selectedTabIndex == 1) {
      content =
          MealsScreen(meals: _favorites, onToggleFavorite: toggleFavoriteMeal);
      pageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_outlined), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border), label: 'Favorites'),
        ],
        currentIndex: _selectedTabIndex,
      ),
    );
  }
}
