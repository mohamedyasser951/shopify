part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

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
