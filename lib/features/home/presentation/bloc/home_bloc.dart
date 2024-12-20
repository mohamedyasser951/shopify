import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo homeRepo;
  CategoryModel? categoryModel;
  HomeModel? homeModel;
  Map<int, bool> inFavorites = {};
  Map<int, bool> inCards = {};

  HomeBloc({
    required this.homeRepo,
  }) : super(HomeState()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeDataEvent) {
        emit(state.copyWith(
          status: Status.loading,
        ));
        var failureOrData = await homeRepo.getHomeData();
        var Categories = await homeRepo.getCategories();

        failureOrData.fold(
            (failure) => emit(state.copyWith(errorMessage: failure.message)),
            (model) {
          homeModel = model;
          for (var item in model.data!.products!) {
            inFavorites.addAll({item.id!: item.inFavorites!});
            inCards.addAll({item.id!: item.inCart!});
          }
        });
        Categories.fold(
            (failure) => emit(state.copyWith(errorMessage: failure.message)),
            (Categories) {
          categoryModel = Categories;
          emit(state.copyWith(
            status: Status.success,
            products: homeModel!.data!.products,
            banners: homeModel!.data!.banners,
            categories: Categories.data!.data,
          ));
        });
      }
    
    });
  }
}
