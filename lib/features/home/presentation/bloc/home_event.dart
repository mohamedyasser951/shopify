part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeAppModeEvent extends HomeEvent {
  final bool? modeFromCashe;
  const ChangeAppModeEvent({
    this.modeFromCashe,
  });
}

class GetHomeDataEvent extends HomeEvent {}

class GetCategoriesEvent extends HomeEvent {}

class GetFavoritesEvent extends HomeEvent {}

class GetCardEvent extends HomeEvent {}

class SetOrDeleteFavoriteEvent extends HomeEvent {
  final int id;
  const SetOrDeleteFavoriteEvent({
    required this.id,
  });
}
