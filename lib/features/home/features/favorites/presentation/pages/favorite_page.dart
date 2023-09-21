import 'package:commerceapp/Config/components/custom_toast.dart';
import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/home/presentation/widgets/FavoritesWidgets/favorite_item.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SetOrDeleteErrorState) {
          customToast(mesg: state.error, color: Colors.red);
        }
        if (state is SetOrDeleteSuccessState) {
          customToast(mesg: state.successMessage);
        }
      },
      builder: (context, state) {
        var favoriteModel = BlocProvider.of<HomeBloc>(context).favoriteModel;
        if (state is GetFavoriteErrorState) {
          return ErrorItem(errorMessage: state.error.toString());
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).favorites),
          ),
          body: favoriteModel == null
              ? const LoadingWidget()
              : ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: favoriteModel.data!.data!.length,
                  itemBuilder: (context, index) => FavoriteItem(
                      model: favoriteModel.data!.data![index].product!),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
        );
      },
    );
  }
}
