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
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(500)),
      child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        CachedNetworkImage(
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          imageUrl: model.image!,
          placeholder: (context, url) => const Loadingitem(
              widget: Skeleton(
            width: 100,
            height: 100,
          )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          width: 100,
          height: 25.0,
          color: Colors.black.withOpacity(0.6),
          child: Text(
            ' ${model.name}',
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
