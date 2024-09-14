import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:flutter/material.dart';

class CrasoulHeader extends StatelessWidget {
  final List<Banners> banners;
  const CrasoulHeader({
    Key? key,
    required this.banners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: banners.length,
      options: CarouselOptions(
        autoPlay: true,
        height: 150,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          width: double.infinity,
          height: 150,
          fit: BoxFit.contain,
          imageUrl: banners[index].image!,
          placeholder: (context, url) => const Loadingitem(
              widget: Skeleton(
            width: 180,
            height: 140,
          )),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      },
    );
  }
}
