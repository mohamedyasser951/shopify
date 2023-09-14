import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/widgets/build_horizontal_categories.dart';
import 'package:commerceapp/features/home/presentation/widgets/carousel_header.dart';
import 'package:commerceapp/features/home/presentation/widgets/grid_view_builder.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          S.of(context).categories,
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
          S.of(context).products,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        gridViewBuilder(products: homeModel.data!.products!)
      ],
    );
  }
}
