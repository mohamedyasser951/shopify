import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/home/features/cart/data/repositories/cartRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo homeRepo;
  CartRepo cartRepo;
  List<Products>? productsByCategory;
  CategoryModel? categoryModel;
  FavoriteModel? favoriteModel;
  HomeModel? homeModel;
  Map<int, bool> inFavorites = {};
  Map<int, bool> inCards = {};
  CardModel? cartModel;

  HomeBloc({
    required this.homeRepo,
    required this.cartRepo,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeDataEvent) {
        emit(GetHomeDataLoadingState());
        var failureOrData = await homeRepo.getHomeData();
        failureOrData.fold(
            (error) => emit(GetHomeDataErrorState(error: error.toString())),
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
            (failure) => emit(GetCategoriesErrorState(error: failure.message)),
            (favorites) {
          favoriteModel = favorites;
          emit(GetFavoriteSuccessSate(favorites: favorites));
        });
      }
      if (event is SetOrDeleteFavoriteEvent) {
        inFavorites[event.id] = !inFavorites[event.id]!;
        emit(ChangeStateOfFavorite());
        var failureOrData =
            await homeRepo.setOrDeleteFromFavorites(id: event.id);
        failureOrData.fold((failure) {
          inFavorites[event.id] = !inFavorites[event.id]!;

          emit(SetOrDeleteErrorState(error: failure.message));
        }, (model) {
          if (!model.status!) {
            inFavorites[event.id] = !inFavorites[event.id]!;
          } else {
            add(GetFavoritesEvent());
          }
          emit(SetOrDeleteSuccessState(
              successMessage: model.message.toString()));
        });
      }

      if (event is GetCardEvent) {
        emit(GetCardLoadingState());
        var failureOrData = await cartRepo.getCarts();
        failureOrData
            .fold((failure) => emit(GetCardSErrorState(error: failure.message)),
                (model) {
          cartModel = model;
          emit(GetCardSuceessState(cardData: cartModel!.data!));
        });
      }
      if (event is AddOrDeleteFromCartEvent) {
        inCards[event.productId] = !inCards[event.productId]!;
        emit(ChangeStateOfCarts());
        var failureOrData =
            await cartRepo.addOrDeleteFromCats(productId: event.productId);
        failureOrData.fold((failure) {
          inCards[event.productId] = !inCards[event.productId]!;

          emit(SetOrDeleteErrorState(error: failure.message));
        }, (data) {
          if (data["status"] != true) {
            inCards[event.productId] = !inCards[event.productId]!;
          } else {
            add(GetCardEvent());
          }
          emit(SetOrDeleteSuccessState(successMessage: data["message"]));
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
