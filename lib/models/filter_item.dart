enum FilterId { glutenFree, lactoseFree, vegetarian, vegan }

class FilterItem {
  const FilterItem(
      {required this.title, required this.subtitle, required this.id});
  final String title;
  final String subtitle;
  final FilterId id;
}
