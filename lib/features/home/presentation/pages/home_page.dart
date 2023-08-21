import 'package:commerceapp/features/home/presentation/pages/search_page.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/widgets/build_horizontal_categories.dart';
import 'package:commerceapp/features/home/presentation/widgets/carousel_header.dart';
import 'package:commerceapp/features/home/presentation/widgets/product_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).home),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchPage());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
        if (state is SetOrDeleteErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is SetOrDeleteSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.successMessage)));
        }
      }, builder: (context, state) {
        if (state is GetCategoriesErrorState) {
          return Center(
            child: Text(
              state.error,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        return cubit.homeModel != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: HomeBody(homeModel: cubit.homeModel!),
                ),
              )
            : const LoadingWidget();
      }),
    );
  }
}

class HomeBody extends StatelessWidget {
  final HomeModel homeModel;
  const HomeBody({
    Key? key,
    required this.homeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CrasoulHeader(banners: homeModel.data!.banners!),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Categories",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 150,
          child: BuildHorizontalCategories(
            categories:
                BlocProvider.of<HomeBloc>(context).categoryModel!.data!.data!,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Products",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: homeModel.data!.products!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .6, crossAxisCount: 2),
          itemBuilder: (context, index) =>
              productItem(product: homeModel.data!.products![index]),
        )
      ],
    );
  }
}
