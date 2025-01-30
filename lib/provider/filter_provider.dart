import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/filter_item.dart';
import 'package:meals_app/provider/meals_provider.dart';

var initialValue = {
  FilterId.glutenFree: false,
  FilterId.lactoseFree: false,
  FilterId.vegetarian: false,
  FilterId.vegan: false
};

class FilterNotifier extends StateNotifier<Map<FilterId, bool>> {
  FilterNotifier() : super(initialValue);

  void setFilter(FilterId key, bool val) {
    state = {...state, key: val};
  }

  void setFilters(Map<FilterId, bool> filters) {
    state = filters;
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<FilterId, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealProvider = Provider((ref) {
  final activeFilters = ref.watch(filterProvider);
  final meals = ref.watch(mealsProvider);

  return meals.where((meal) {
    if (activeFilters[FilterId.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterId.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterId.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[FilterId.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
