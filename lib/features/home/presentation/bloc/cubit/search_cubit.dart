import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  HomeRepo homeRepo;

  SearchCubit(
    this.homeRepo,
  ) : super(SearchInitial());

  void search({required String text}) async {
    emit(SearchLoadingState());
    var failureOrData = await homeRepo.search(text: text);
    failureOrData
        .fold((failure) => emit(SearchErrorState(error: failure.message)),
            (products) {
      emit(SearchSuccessState(products: products));
    });
  }
}
