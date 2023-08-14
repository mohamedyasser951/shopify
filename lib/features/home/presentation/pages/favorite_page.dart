import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(GetFavoritesEvent());
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GetFavoritesLoadingState) {
          return const LoadingWidget();
        } else if (state is GetFavoriteErrorState) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else if (state is GetFavoriteSuccessSate) {
          return Scaffold(
            body: ListView.separated(
              itemCount: state.favorites.data!.data.length,
              itemBuilder: (context, index) => FavoriteItem(
                  model: state.favorites.data!.data[index].product!),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final Product model;
  const FavoriteItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 100.0,
        child: Row(children: [
          SizedBox(
            width: 100.0,
            height: 100.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                  imageUrl: model.image,
                  placeholder: (context, url) => const Loadingitem(
                      widget: Skeleton(
                    width: 180,
                    height: 140,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                if (model.discount != 0)
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50.0))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "${model.price}",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (true)
                    Text(
                      "${model.oldPrice}",
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    // backgroundColor:
                    //     CubitHomeLayout.get(context).favoriets[model.id]!
                    //         ? defeaultColor
                    //         : Colors.grey,
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        // CubitHomeLayout.get(context).changeFavorItes(model.id!);
                      },
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
        ]),
      ),
    );
  }
}
