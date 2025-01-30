import 'package:meals_app/models/filter_item.dart';

const filtersContent = [
  FilterItem(
    title: 'Gluten-free',
    subtitle: 'Only include gluten-free meals.',
    id: FilterId.glutenFree,
  ),
  FilterItem(
    title: 'Lactose-free',
    subtitle: 'Only include lactose-free meals.',
    id: FilterId.lactoseFree,
  ),
  FilterItem(
    title: 'Vegetarian',
    subtitle: 'Only include vegetarian meals.',
    id: FilterId.vegetarian,
  ),
  FilterItem(
    title: 'Vegan',
    subtitle: 'Only include vegan meals.',
    id: FilterId.vegan,
  ),
];
