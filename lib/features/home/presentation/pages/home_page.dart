import 'package:commerceapp/features/home/presentation/widgets/carousel_header.dart';
import 'package:commerceapp/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is GetHomeDataLoadingState) {
          return const LoadingWidget();
        } else if (state is GetHomeDataSuccessState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CrasoulHeader(banners: state.homeModel.data!.banners!),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.homeModel.data!.products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .6, crossAxisCount: 2),
                  itemBuilder: (context, index) => productItem(
                      product: state.homeModel.data!.products![index]),
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
