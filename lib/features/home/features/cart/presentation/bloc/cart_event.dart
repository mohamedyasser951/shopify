part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCardEvent extends CartEvent {}

class AddOrDeleteFromCartEvent extends CartEvent {
  final int productId;
  const AddOrDeleteFromCartEvent({
    required this.productId,
  });
}
