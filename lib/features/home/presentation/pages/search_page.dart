import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/pages/product_details_page.dart';
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
            // BlocProvider.of<HomeBloc>(context).add(SearchEvent(text: query));
            query = "";
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      // if (state is SearchLoadingState) {
      //   return const LoadingWidget();
      // } else if (state is SearchErrorState) {
      //   return Center(
      //     child: Text(state.error),
      //   );
      // } else if (state is SearchSuccessState) {
      //   return ListView.separated(
      //     itemCount: state.products.length,
      //     separatorBuilder: (context, index) => const SizedBox(
      //       height: 10,
      //     ),
      //     itemBuilder: (context, index) => InkWell(
      //         onTap: () {
      //           showResults(context);
      //         },
      //         child: FavoriteItem(model: state.products[index])),
      //   );
      // } else {
      //   return Center(child: Text(S.of(context).search_now));
      // }
      HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
      List<Products> products = homeBloc.homeModel!.data!.products!;

      List results = query.isEmpty
          ? products
          : products.where((element) => element.name!.contains(query)).toList();

      return results.isEmpty
          ? const ErrorItem(errorMessage: "No Results Founded..")
          : ListView.separated(
              itemCount: results.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showResults(context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) =>
                    //       ProductDetails(product: products[index]),
                    // ));
                  },
                  child: FavoriteItem(model: results[index])),
            );
    });
  }
}
