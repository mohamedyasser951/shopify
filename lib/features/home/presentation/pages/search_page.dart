import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/widgets/FavoritesWidgets/favorite_item.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(SearchEvent(text: query));
            // query = "";
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  List product = ["ahmed", "yasser", "Nada"];

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is SearchLoadingState) {
        return const LoadingWidget();
      } else if (state is SearchErrorState) {
        return Center(
          child: Text(state.error),
        );
      } else if (state is SearchSuccessState) {
        return ListView.separated(
          itemCount: state.products.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                showResults(context);
              },
              child: FavoriteItem(model: state.products[index])),
        );
      } else {
        return Center(child: Text(S.of(context).search_now));
      }
    });
  }
}
