import 'package:commerceapp/Config/components/cachedNetworkImage.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var homeBloc = BlocProvider.of<HomeBloc>(context);
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ));
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              height: 270,
              width: 150,
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CashedNetworkImage(
                    height: 180,
                    width: 180,
                    imgUrl: product.image!,
                  ),
                  Text(
                    product.name!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 15, color: AppColors.primaryColor)),
                      const Spacer(),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context).add(
                              AddOrDeleteFromCartEvent(productId: product.id!));
                        },
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                homeBloc.inCards[product.id] == true
                                    ? Colors.green
                                    : Colors.grey,
                            child: const Center(
                              child: Icon(
                                Icons.shopping_cart,
                                size: 14,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                onTap: () {
                  homeBloc.add(SetOrDeleteFavoriteEvent(id: product.id!));
                },
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: homeBloc.inFavorites[product.id] == true
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
            ),
          ],
        ),
      ),
    );
  }
}
