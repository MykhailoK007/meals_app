import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.label, required this.icon});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: Colors.white),
      SizedBox(width: 6),
      Text(label, style: TextStyle(color: Colors.white))
    ]);
  }
}
