import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategortItem extends StatelessWidget {
  final CategoryData categoryData;
  const CategortItem({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeBloc>(context)
            .add(GetCategoriesDetailsEvent(categoryId: categoryData.id!));
        Navigator.pushNamed(context, "/getCategoryDetails",
            arguments: categoryData.name);
      },
      child: SizedBox(
        height: 100,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: CachedNetworkImage(
                    height: 80,
                    width: 80,
                    imageUrl: categoryData.image!,
                    placeholder: (context, url) => const Loadingitem(
                        widget: Skeleton(
                      width: 8,
                      height: 80,
                    )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Text(
                  categoryData.name!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
