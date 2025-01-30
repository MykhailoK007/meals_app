import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    this.color = const Color.fromRGBO(255, 183, 77, 1),
    required this.title,
  });
  final String title;
  final String id;
  final Color color;
}
