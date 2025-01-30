import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/filter_options.dart';
import 'package:meals_app/models/filter_item.dart';
import 'package:meals_app/provider/filter_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    void changeFilter(FilterId id, bool value) {
      ref.read(filterProvider.notifier).setFilter(id, value);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      body: Column(
        children: [
          ...filtersContent.map((filter) => SwitchListTile(
                value: activeFilters[filter.id]!,
                onChanged: (value) {
                  changeFilter(filter.id, value);
                },
                title: Text(
                  filter.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                subtitle: Text(
                  filter.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: EdgeInsets.only(left: 30, right: 20),
              ))
        ],
      ),
    );
  }
}
