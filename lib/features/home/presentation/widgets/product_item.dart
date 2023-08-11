import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';

class productItem extends StatelessWidget {
  final Products product;
  const productItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      height: 260,
      width: 150,
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CachedNetworkImage(
                width: 180,
                height: 180,
                imageUrl: product.image!,
                placeholder: (context, url) => const Loadingitem(
                    widget: Skeleton(
                  width: 180,
                  height: 180,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(30),
                   color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    ImagesPath.favorite,
                    width: 18,
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 4.0),
          Text(
            product.name!,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          Row(
            children: [
              Text(product.price.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16)),
              const SizedBox(width: 15.0),
              Text(
                product.discount.toString(),
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.primaryColor,
                    fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
