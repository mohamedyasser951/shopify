import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:equatable/equatable.dart';

import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';

part 'categories_details_state.dart';

class CategoriesDetailsCubit extends Cubit<CategoriesDetailsState> {
  HomeRepo homeRepo;
  CategoriesDetailsCubit({
    required this.homeRepo,
  }) : super(CategoriesDetailsState());

  void getCategoriesDetails({required int categoryId}) async {
    emit(state.copyWith(status: Status.loading));
    var failureOrData = await homeRepo.getCategoriesDetails(id: categoryId);
    failureOrData.fold(
        (failure) => emit(state.copyWith(
            status: Status.error, errorMessage: failure.message)), (products) {
      emit(state.copyWith(
        status: Status.success,
        products: products,
      ));
    });
  }
}
