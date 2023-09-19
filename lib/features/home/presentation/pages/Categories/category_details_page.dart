import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/features/home/presentation/widgets/grid_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String categoryName;
  const CategoryDetailsPage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
          if (state is CategoriesDetailsErrorState) {
            return ErrorItem(errorMessage: state.error);
          }
          if (state is CategoriesDetailsErrorState) {
            return Center(
                child: ErrorItem(
              errorMessage: state.error,
            ));
          }
          return state is CategoriesDetailsLoadingState
              ? const LoadingWidget()
              : gridViewBuilder(products: homeBloc.productsByCategory!);
        }),
      ),
    );
  }
}
