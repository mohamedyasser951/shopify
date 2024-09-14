part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeBottomNavEvent extends HomeEvent {
  final int index;
  const ChangeBottomNavEvent({
    required this.index,
  });
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

class SearchEvent extends HomeEvent {
  final String text;
  const SearchEvent({
    required this.text,
  });
}
