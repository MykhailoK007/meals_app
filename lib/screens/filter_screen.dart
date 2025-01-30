import 'package:flutter/material.dart';
import 'package:meals_app/data/filter_options.dart';
import 'package:meals_app/models/filter_item.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});
  final Map<FilterId, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var filterValues = {
    FilterId.glutenFree: false,
    FilterId.lactoseFree: false,
    FilterId.vegetarian: false,
    FilterId.vegan: false
  };

  void _changeFilter(FilterId key, bool val) {
    setState(() {
      filterValues[key] = val;
    });
  }

  @override
  void initState() {
    super.initState();
    filterValues = widget.currentFilters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop(filterValues);
        },
        child: Column(
          children: [
            ...filtersContent.map((filter) => SwitchListTile(
                  value: filterValues[filter.id]!,
                  onChanged: (value) {
                    _changeFilter(filter.id, value);
                  },
                  title: Text(
                    filter.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  subtitle: Text(
                    filter.subtitle,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  contentPadding: EdgeInsets.only(left: 30, right: 20),
                ))
          ],
        ),
      ),
    );
  }
}
