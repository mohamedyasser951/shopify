import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetails extends StatelessWidget {
  final Products product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).product_detail)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Card(
                        child: CarouselSlider.builder(
                          itemCount: product.images!.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            height: 200,
                            viewportFraction: 1,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            return CachedNetworkImage(
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.contain,
                              imageUrl: product.images![index],
                              placeholder: (context, url) => const Loadingitem(
                                  widget: Skeleton(
                                width: 180,
                                height: 140,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundColor: BlocProvider.of<HomeBloc>(context)
                                        .inFavorites[product.id] ==
                                    true
                                ? AppColors.primaryColor
                                : Colors.grey,
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      SetOrDeleteFavoriteEvent(
                                          id: product.id!));
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  size: 12,
                                  color: Colors.white,
                                ))),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).name,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        const Spacer(),
                        Text(
                          "${product.price}\$",
                          style: TextStyle(color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                  Text(
                    product.name!,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      S.of(context).description,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                  Text(
                    product.description!,
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: const BottomSheetButtons(),
    );
  }
}

class BottomSheetButtons extends StatelessWidget {
  const BottomSheetButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: SvgPicture.asset(ImagesPath.activeCard),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.primaryColor),
              child: Text(
                S.of(context).buy_now,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
