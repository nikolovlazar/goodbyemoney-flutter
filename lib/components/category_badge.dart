import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodbye_money/models/category.dart';

class CategoryBadge extends StatelessWidget {
  final Category? category;

  const CategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
      decoration: BoxDecoration(
        color: category?.color.withAlpha(102) ?? CupertinoColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category?.name ?? "Unknown",
        style: TextStyle(
          color: category?.color ?? CupertinoColors.black,
          fontSize: 13,
        ),
      ),
    );
  }
}
