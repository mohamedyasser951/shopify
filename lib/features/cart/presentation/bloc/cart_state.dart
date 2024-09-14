part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaddedState extends CartState {
  final CardData cartdata;
  CartLoaddedState({required this.cartdata});
  @override
  List<Object> get props => [cartdata];
}

class CartErrorState extends CartState {
  final String error;
  CartErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

// class CartMessageState extends CartState{
//    final String message;
//   CartMessageState({required this.message});
//   @override
//   List<Object> get props => [message];
// }
