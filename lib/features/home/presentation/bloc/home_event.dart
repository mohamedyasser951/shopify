part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeDataEvent extends HomeEvent {}

class GetCategoriesEvent extends HomeEvent {}

class GetCategoriesDetailsEvent extends HomeEvent {
  final int categoryId;
  const GetCategoriesDetailsEvent({
    required this.categoryId,
  });
}

class GetFavoritesEvent extends HomeEvent {}

// class GetCardEvent extends HomeEvent {}

class SetOrDeleteFavoriteEvent extends HomeEvent {
  final int id;
  const SetOrDeleteFavoriteEvent({
    required this.id,
  });
}

// class SetOrDeleteFromCartEvent extends HomeEvent {
//   final int productId;
//   const SetOrDeleteFromCartEvent({
//     required this.productId,
//   });
// }

class SearchEvent extends HomeEvent {
  final String text;
  const SearchEvent({
    required this.text,
  });
}
