part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ChangeAppModeState extends HomeState {}

class GetHomeDataLoadingState extends HomeState {}

class GetHomeDataSuccessState extends HomeState {
  final HomeModel homeModel;
  const GetHomeDataSuccessState({
    required this.homeModel,
  });
  @override
  List<Object> get props => [homeModel];
}

class GetHomeDataErrorState extends HomeState {
  final String error;
  const GetHomeDataErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// Get Categories

class GetCategoriesLoadingState extends HomeState {}

class GetCategoriesSuccessState extends HomeState {
  final CategoryModel categoryModel;
  const GetCategoriesSuccessState({
    required this.categoryModel,
  });
  @override
  List<Object> get props => [categoryModel];
}

class GetCategoriesErrorState extends HomeState {
  final String error;
  const GetCategoriesErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

// get Card
class GetCardLoadingState extends HomeState {}

class GetCardSuceessState extends HomeState {}

class GetCardSErrorState extends HomeState {
  final String error;
  const GetCardSErrorState({
    required this.error,
  });
}

// get Faoirtes

class GetFavoritesLoadingState extends HomeState {}

class GetFavoriteSuccessSate extends HomeState {
  final FavoriteModel favorites;
  const GetFavoriteSuccessSate({
    required this.favorites,
  });
  @override
  List<Object> get props => [favorites];
}

class GetFavoriteErrorState extends HomeState {
  final String error;
  const GetFavoriteErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class SetOrDeleteSuccessState extends HomeState {
  final String successMessage;
  const SetOrDeleteSuccessState({
    required this.successMessage,
  });
}

class SetOrDeleteErrorState extends HomeState {
  final String error;
  const SetOrDeleteErrorState({
    required this.error,
  });
}

class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {
  final List<Products> products;
  const SearchSuccessState({
    required this.products,
  });
}

class SearchErrorState extends HomeState {
  final String error;
  const SearchErrorState({
    required this.error,
  });
}
