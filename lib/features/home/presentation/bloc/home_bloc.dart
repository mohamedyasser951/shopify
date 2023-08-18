import 'package:bloc/bloc.dart';
import 'package:commerceapp/Config/Network/error_strings.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/home/data/models/card_model.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo homeRepo;
  CategoryModel? categoryModel;
  CardModel? cardModel;
  HomeModel? homeModel;
  Map<int, bool> inFavorites = {};
  Map<int, bool> inCards = {};
  bool isDarkMode = false;

  HomeBloc({
    required this.homeRepo,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is ChangeAppModeEvent) {
        if (event.modeFromCashe != null) {
          isDarkMode = event.modeFromCashe!;
          emit(ChangeAppModeState());
        } else {
          isDarkMode = !isDarkMode;
          var box = Hive.box(AppStrings.settingsBox);
          box.put("darkMode", isDarkMode);
          emit(ChangeAppModeState());
        }
      }
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
      if (event is GetFavoritesEvent) {
        emit(GetFavoritesLoadingState());
        var failureOrData = await homeRepo.getFavorites();
        failureOrData.fold(
            (error) => emit(
                GetCategoriesErrorState(error: mapFailureToMessage(error))),
            (favorites) => emit(GetFavoriteSuccessSate(favorites: favorites)));
      }
      if (event is SetOrDeleteFavoriteEvent) {
        inFavorites[event.id] = !inFavorites[event.id]!;

        var failureOrData =
            await homeRepo.setOrDeleteFromFavorites(id: event.id);
        failureOrData.fold((failure) {
          inFavorites[event.id] = !inFavorites[event.id]!;

          emit(SetOrDeleteErrorState(error: mapFailureToMessage(failure)));
        }, (model) {
          if (!model.status!) {
            inFavorites[event.id] = !inFavorites[event.id]!;
          } else {
            homeRepo.getFavorites();
          }
          emit(SetOrDeleteSuccessState(
              successMessage: model.message.toString()));
        });
      }

      if (event is GetCardEvent) {
        emit(GetCardLoadingState());
        var failureOrData = await homeRepo.getCard();
        failureOrData.fold(
            (failure) =>
                emit(GetCardSErrorState(error: mapFailureToMessage(failure))),
            (model) {
          cardModel = model;
          emit(GetCardSuceessState());
        });
      }
    });
  }
}
