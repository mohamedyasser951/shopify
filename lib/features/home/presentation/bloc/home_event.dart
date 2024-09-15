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



