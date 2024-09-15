import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/favorites/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  HomeRepo homeRepo;
  FavoritesBloc({required this.homeRepo}) : super(FavoritesState()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetAllFavoritesEvent) {
        emit(state.copyWith(status: Status.loading));
        var failureOrData = await homeRepo.getFavorites();
        failureOrData.fold(
            (failure) => emit(state.copyWith(
                  status: Status.error,
                  errorMessage: failure.message,
                )), (favorites) {
          emit(state.copyWith(
              status: Status.success, favoriteData: favorites.data!.data));
        });
      }
    });
  }
}
