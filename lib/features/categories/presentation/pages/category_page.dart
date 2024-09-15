import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/widgets/vertical_category_item.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).categories),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return LoadingWidget();
            case Status.error:
              return ErrorItem(errorMessage: state.errorMessage);
            case Status.success:
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.categories!.length,
                    itemBuilder: (context, index) => CategortItem(
                        categoryData: state.categories![index]),
                  ),
                );
          }
        }));
        }
  }

