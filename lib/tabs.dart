import 'package:flutter/material.dart';
import 'package:meals_app/main_drawer.dart';
import 'package:meals_app/models/filter_item.dart';
import 'package:meals_app/provider/favorite_provider.dart';
import 'package:meals_app/provider/filter_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

const Map<FilterId, bool> initialFilters = {
  FilterId.glutenFree: false,
  FilterId.lactoseFree: false,
  FilterId.vegetarian: false,
  FilterId.vegan: false
};

class _TabsState extends ConsumerState<Tabs> {
  int _selectedTabIndex = 0;

  void _selectTab(int tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<FilterId, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteProvider);
    final availableMeals = ref.watch(filteredMealProvider);

    Widget content = CategoriesScreen(availableMeals: availableMeals);

    String pageTitle = 'Categories';

    if (_selectedTabIndex == 1) {
      content = MealsScreen(meals: favoriteMeals);
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
