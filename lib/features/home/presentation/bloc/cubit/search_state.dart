part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Products> products;
  const SearchSuccessState({
    required this.products,
  });
}

class SearchErrorState extends SearchState {
  final String error;
  const SearchErrorState({
    required this.error,
  });
}