part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

// Get Carts

class GetCardLoadingState extends CartState {}

class GetCardSuceessState extends CartState {
  final CardData cardData;
  const GetCardSuceessState({
    required this.cardData,
  });
}

class GetCardSErrorState extends CartState {
  final String error;
  const GetCardSErrorState({
    required this.error,
  });
}

class ChangeStateOfCarts extends CartState {}

// // add or delete

// class AddOrDeleteSuccessState extends CartState {
//   final String successMessage;
//   const AddOrDeleteSuccessState({
//     required this.successMessage,
//   });
// }

// class AddOrDeleteErrorState extends CartState {
//   final String error;
//   const AddOrDeleteErrorState({
//     required this.error,
//   });
// }

// delete cart

// class DeleteCartSuccessState extends CartState {}

// class DeleteCartErrorState extends CartState {
//   final String error;
//   const DeleteCartErrorState({
//     required this.error,
//   });
// }
// // updatae cart

// class UpdateCartSuccessState extends CartState {}

// class UpdateCartErrorState extends CartState {
//   final String error;
//   const UpdateCartErrorState({
//     required this.error,
//   });
// }
