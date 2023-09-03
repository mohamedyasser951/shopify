import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';

class productItem extends StatelessWidget {
  final Products product;
  const productItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ));
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          height: 260,
          width: 150,
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                width: 8,
              ),
              Text(
                product.name!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // if (product.discount != 0)
                  //   Text(
                  //     "${product.discount}\$",
                  //     style: TextStyle(
                  //         decoration: TextDecoration.lineThrough,
                  //         color: AppColors.grayColor,
                  //         fontSize: 14),
                  //   ),
                  // if (product.discount != 0) const SizedBox(width: 15.0),
                  Text("${product.price}\$",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15, color: AppColors.primaryColor)),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(SetOrDeleteFavoriteEvent(id: product.id!));
                    },
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: BlocProvider.of<HomeBloc>(context)
                                    .inFavorites[product.id] ==
                                true
                            ? AppColors.primaryColor
                            : Colors.grey,
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            size: 12,
                            color: Colors.white,
                          ),
                        )),
                  ),
                    const SizedBox(
                      width: 4,
                    ),
                   InkWell(
                    onTap: () {
                      
                    },
                    child: const CircleAvatar(
                        radius: 15,
                        backgroundColor:Colors.green,
                        child: Center(
                          child: Icon(
                            Icons.shop,
                            size: 12,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
