import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/presentation/widgets/horizontal_category_item.dart';
import 'package:flutter/material.dart';

class BuildHorizontalCategories extends StatelessWidget {
  final List<CategoryData> categories;
  const BuildHorizontalCategories({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(
        width: 6,
      ),
      itemBuilder: (context, index) =>
          HorizontalCategoryItem(model: categories[index]),
    );
  }
}
