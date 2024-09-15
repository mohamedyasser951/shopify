part of 'home_bloc.dart';

enum Status { loading, success, error }

class HomeState extends Equatable {
  final Status status;
  final List<Products>? products;
  final List<Banners>? banners;
  final List<CategoryData>? categories;
  final String errorMessage;

  const HomeState({
    this.status = Status.loading,
    this.products = const [],
    this.banners = const [],
    this.categories = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    Status? status,
    List<Products>? products,
    List<Banners>? banners,
    List<CategoryData>? categories,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      banners: banners ?? this.banners,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        this.banners,
        this.categories,
        this.errorMessage,
        this.products,
        this.status
      ];
}




// class HomeInitial extends HomeState {}


// class GetHomeDataLoadingState extends HomeState {}

// class GetHomeDataSuccessState extends HomeState {
//   final HomeModel homeModel;
//     final CategoryModel categoryModel;

//   const GetHomeDataSuccessState({
//     required this.homeModel,
//     required this.categoryModel,
//   });
//   @override
//   List<Object> get props => [homeModel];
// }

// class GetHomeDataErrorState extends HomeState {
//   final String error;
//   const GetHomeDataErrorState({
//     required this.error,
//   });

//   @override
//   List<Object> get props => [error];
// }


//Get Categories Details
// class CategoriesDetailsLoadingState extends HomeState {}

// class CategoriesDetailsSuccessState extends HomeState {}

// class CategoriesDetailsErrorState extends HomeState {
//   final String error;
//   const CategoriesDetailsErrorState({
//     required this.error,
//   });
//   @override
//   List<Object> get props => [error];
// }

// Get Categories



// class GetFavoritesLoadingState extends HomeState {}

// class GetFavoriteSuccessSate extends HomeState {
//   final FavoriteModel favorites;
//   const GetFavoriteSuccessSate({
//     required this.favorites,
//   });
// }

// class GetFavoriteErrorState extends HomeState {
//   final String error;
//   const GetFavoriteErrorState({
//     required this.error,
//   });
//   @override
//   List<Object> get props => [error];
// }

// // class ChangeStateOfFavorite extends HomeState {}

// class SetOrDeleteSuccessState extends HomeState {
//   final String successMessage;
//   const SetOrDeleteSuccessState({
//     required this.successMessage,
//   });
// }

// class SetOrDeleteErrorState extends HomeState {
//   final String error;
//   const SetOrDeleteErrorState({
//     required this.error,
//   });
// }



