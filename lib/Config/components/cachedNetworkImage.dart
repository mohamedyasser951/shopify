import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';

class CashedNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final String imgUrl;

  const CashedNetworkImage({
    Key? key,
    required this.width,
    required this.height,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      placeholder: (context, url) => Loadingitem(
          widget: Skeleton(
        width: width,
        height: height,
      )),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
