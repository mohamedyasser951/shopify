part of 'categories_details_cubit.dart';

class CategoriesDetailsState extends Equatable {
  final Status status;
  final List<Products>? products;
  final String errorMessage;

  const CategoriesDetailsState({
    this.status = Status.loading,
    this.products = const [],
    this.errorMessage = '',
  });

  CategoriesDetailsState copyWith({
    Status? status,
    List<Products>? products,
    String? errorMessage,
  }) {
    return CategoriesDetailsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [this.errorMessage, this.products, this.status];
}
