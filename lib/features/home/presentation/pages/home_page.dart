import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/widgets/carousel_header.dart';
import 'package:commerceapp/features/home/presentation/widgets/product_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return const LoadingWidget();
        } else if (state is GetHomeDataSuccessState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CrasoulHeader(banners: state.homeModel.data!.banners!),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.homeModel.data!.products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .6, crossAxisCount: 2),
                  itemBuilder: (context, index) => productItem(
                      product: state.homeModel.data!.products![index]),
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

class CategortItem extends StatelessWidget {
  final CategoryData categoryData;
  const CategortItem({
    Key? key,
    required this.categoryData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Row(
          children: [
            Text(
              categoryData.name!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            SizedBox(
              child: CachedNetworkImage(
                height: 100,
                imageUrl: categoryData.image!,
                placeholder: (context, url) => const Loadingitem(
                    widget: Skeleton(
                  width: 180,
                  height: 180,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
