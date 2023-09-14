
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';

GridView gridViewBuilder({required List<Products> products}) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: .6, crossAxisCount: 2),
    itemBuilder: (context, index) => productItem(product: products[index]),
  );
}