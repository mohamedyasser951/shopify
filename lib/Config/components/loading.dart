import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loadingitem extends StatelessWidget {
  final Widget widget;
  const Loadingitem({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.withOpacity(0.4),
      child: widget,
    );
  }
}
