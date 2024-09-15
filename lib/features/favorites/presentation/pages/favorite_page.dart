import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/favorites/presentation/widgets/FavoritesWidgets/favorite_item.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).favorites),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return LoadingWidget();
              case Status.error:
                return ErrorItem(errorMessage: state.errorMessage);
              case Status.success:
                return ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.favoriteData!.length,
                  itemBuilder: (context, index) =>
                      FavoriteItem(model: state.favoriteData![index].product!),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                );
            }
          },
        ));
  }
}
