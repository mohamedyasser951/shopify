import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cardModel = BlocProvider.of<HomeBloc>(context).cardModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is GetCardSErrorState) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        return state is GetCardLoadingState
            ? const LoadingWidget()
            : ListView.separated(
                itemCount: cardModel!.data!.cartItems!.length,
                itemBuilder: (context, index) => CardWidget(
                    product: cardModel.data!.cartItems![index].product!),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
              );
      }),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Products product;
  const CardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            color: Theme.of(context).colorScheme.background,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CachedNetworkImage(
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    imageUrl: product.image!,
                    placeholder: (context, url) => const Loadingitem(
                        widget: Skeleton(
                      width: 100,
                      height: 100,
                    )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${product.price}\$",
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text("  1  ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 16)),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 5),
          child: CircleAvatar(
            radius: 15.0,
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                ImagesPath.activeCard,
                color: Colors.white,
                width: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
