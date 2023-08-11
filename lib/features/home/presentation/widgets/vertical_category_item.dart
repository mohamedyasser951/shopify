

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategortItem extends StatelessWidget {
  final CategoryData categoryData;
  const CategortItem({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Row(
          children: [
            Text(
              categoryData.name!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            SizedBox(
              child: CachedNetworkImage(
                height: 100,
                imageUrl: categoryData.image!,
                placeholder: (context, url) => const Loadingitem(
                    widget: Skeleton(
                  width: 180,
                  height: 180,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}