import 'package:bloc/bloc.dart';
import 'package:commerceapp/Config/Network/error_strings.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo homeRepo;
  List<Products>? productsByCategory;
  CategoryModel? categoryModel;
  // CardModel? cardModel;
  FavoriteModel? favoriteModel;
  HomeModel? homeModel;
  Map<int, bool> inFavorites = {};
  Map<int, bool> inCards = {};

  HomeBloc({
    required this.homeRepo,
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
            (error) => emit(GetCategoriesErrorState(error: error.toString())),
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
            (failure) => emit(CategoriesDetailsErrorState(
                error: mapFailureToMessage(failure))), (products) {
          productsByCategory = products;
          emit(CategoriesDetailsSuccessState());
        });
      }
      if (event is GetFavoritesEvent) {
        emit(GetFavoritesLoadingState());
        var failureOrData = await homeRepo.getFavorites();
        failureOrData.fold(
            (error) => emit(
                GetCategoriesErrorState(error: mapFailureToMessage(error))),
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

          emit(SetOrDeleteErrorState(error: mapFailureToMessage(failure)));
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

      // if (event is GetCardEvent) {
      //   emit(GetCardLoadingState());
      //   var failureOrData = await homeRepo.getCard();
      //   failureOrData.fold(
      //       (failure) =>
      //           emit(GetCardSErrorState(error: mapFailureToMessage(failure))),
      //       (model) {
      //     cardModel = model;
      //     emit(GetCardSuceessState());
      //   });
      // }
      // if (event is SetOrDeleteFromCartEvent) {
      //   inCards[event.productId] = !inCards[event.productId]!;
      //   emit(ChangeStateOfCarts());
      //   var failureOrData =
      //       await homeRepo.setOrDeleteFromCart(productId: event.productId);
      //   failureOrData.fold((failure) {
      //     inCards[event.productId] = !inCards[event.productId]!;

      //     emit(SetOrDeleteErrorState(error: mapFailureToMessage(failure)));
      //   }, (data) {
      //     if (data["status"] != true) {
      //       inCards[event.productId] = !inCards[event.productId]!;
      //     } else {
      //       add(GetCardEvent());
      //     }
      //     emit(SetOrDeleteSuccessState(successMessage: data["message"]));
      //   });
      // }
      if (event is SearchEvent) {
        emit(SearchLoadingState());
        var failureOrData = await homeRepo.search(text: event.text);
        failureOrData.fold(
            (failure) =>
                emit(SearchErrorState(error: mapFailureToMessage(failure))),
            (products) {
          emit(SearchSuccessState(products: products));
        });
      }
    });
  }
}
