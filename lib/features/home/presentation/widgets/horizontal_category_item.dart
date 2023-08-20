import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:flutter/material.dart';

class HorizontalCategoryItem extends StatelessWidget {
  final CategoryData model;
  const HorizontalCategoryItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(children: [
          CachedNetworkImage(
            width: 100,
            height: 100,
            fit: BoxFit.contain,
            imageUrl: model.image!,
            placeholder: (context, url) => const Loadingitem(
                widget: Skeleton(
              width: 100,
              height: 100,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(
            model.name!.split(" ")[0],
            style: const TextStyle(
                overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
