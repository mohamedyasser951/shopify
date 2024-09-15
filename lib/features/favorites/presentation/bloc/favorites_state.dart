part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final Status status;
  final   List<ProductData>? favoriteData ;
  final String errorMessage;

  const FavoritesState({
    this.status = Status.loading,
    this.favoriteData = const [],
    this.errorMessage = '',
  });

  FavoritesState copyWith({
    Status? status,
    List<ProductData>? favoriteData,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favoriteData: favoriteData ?? this.favoriteData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [this.errorMessage, this.favoriteData, this.status];
}