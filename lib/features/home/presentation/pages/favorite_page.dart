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
              itemCount: state.favorites.data!.data!.length,
              itemBuilder: (context, index) => Text(state.favorites.data!.data!.length.toString()),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          );
        }
        return Text("000");
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final FavoriteData model;
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
                Image(
                    height: 200.0, image: NetworkImage(model.product!.image!)),
                if (model.product!.discount != 0)
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
              Text("${model.product!.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: Colors.black,
                  )),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "${model.product!.price}}",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (true)
                    Text(
                      "${model.product!.oldPrice}",
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
