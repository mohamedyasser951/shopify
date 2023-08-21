import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var favoriteModel = BlocProvider.of<HomeBloc>(context).favoriteModel;
    // BlocProvider.of<HomeBloc>(context).add(GetFavoritesEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetFavoriteErrorState) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title:  Text(S.of(context).favorites),
          ),
          body: state is GetFavoritesLoadingState
              ? const LoadingWidget()
              : ListView.separated(
                  itemCount: favoriteModel!.data!.data.length,
                  itemBuilder: (context, index) => FavoriteItem(
                      model: favoriteModel.data!.data[index].product!),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
        );
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final Products model;
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
                  imageUrl: model.image!,
                  placeholder: (context, url) => const Loadingitem(
                      widget: Skeleton(
                    width: 180,
                    height: 140,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                if (model.discount != 0 && model.discount != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40.0))),
                    child:  Text(
                      S.of(context).discount,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
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
                  if (model.discount != 0 && model.discount != null)
                    Text(
                      "${model.oldPrice}\$",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.grayColor,
                          fontSize: 16),
                    ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text("${model.price}\$",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16, color: AppColors.primaryColor)),
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
                        BlocProvider.of<HomeBloc>(context)
                            .add(SetOrDeleteFavoriteEvent(id: model.id!));
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
