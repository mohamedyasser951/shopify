import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/cart/data/repositories/cart_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo homeRepo;
  CartRepo cartRepo;
  int bottomNavIndex = 0;
  List<Products>? productsByCategory;
  CategoryModel? categoryModel;
  FavoriteModel? favoriteModel;
  HomeModel? homeModel;
  Map<int, bool> inFavorites = {};
  Map<int, bool> inCards = {};

  HomeBloc({
    required this.homeRepo,
    required this.cartRepo,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is ChangeBottomNavEvent) {
        bottomNavIndex = event.index;
        if (event.index == 2) {
          // add(GetCardEvent());
        }
        if (event.index == 3 && favoriteModel == null) {
          add(GetFavoritesEvent());
        }
        emit(ChangeBottomNavState(index: bottomNavIndex));
      }
      if (event is GetHomeDataEvent) {
        emit(GetHomeDataLoadingState());
        var failureOrData = await homeRepo.getHomeData();
        failureOrData.fold(
            (failure) => emit(GetHomeDataErrorState(error: failure.message)),
            (model) {
          homeModel = model;
          for (var item in model.data!.products!) {
            inFavorites.addAll({item.id!: item.inFavorites!});
            inCards.addAll({item.id!: item.inCart!});
          }
          emit(GetHomeDataSuccessState(homeModel: model));
        });
      }
      if (event is GetCategoriesEvent) {
        emit(GetCategoriesLoadingState());
        var failureOrData = await homeRepo.getCategories();
        failureOrData.fold(
            (error) => emit(GetCategoriesErrorState(error: error.message)),
            (model) {
          categoryModel = model;
          emit(GetCategoriesSuccessState(categoryModel: model));
        });
      }
      if (event is GetCategoriesDetailsEvent) {
        emit(CategoriesDetailsLoadingState());
        var failureOrData =
            await homeRepo.getCategoriesDetails(id: event.categoryId);
        failureOrData.fold(
            (failure) =>
                emit(CategoriesDetailsErrorState(error: failure.message)),
            (products) {
          productsByCategory = products;
          emit(CategoriesDetailsSuccessState());
        });
      }
      if (event is GetFavoritesEvent) {
        emit(GetFavoritesLoadingState());
        var failureOrData = await homeRepo.getFavorites();
        failureOrData.fold(
            (failure) => emit(GetFavoriteErrorState(error: failure.message)),
            (favorites) {
          favoriteModel = favorites;
          emit(GetFavoriteSuccessSate(favorites: favorites));
        });
      }

      if (event is SearchEvent) {
        emit(SearchLoadingState());
        var failureOrData = await homeRepo.search(text: event.text);
        failureOrData
            .fold((failure) => emit(SearchErrorState(error: failure.message)),
                (products) {
          emit(SearchSuccessState(products: products));
        });
      }
    });
  }
}
