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
