part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetAllCarts extends CartEvent {}

class AddOrRemoveCartEvent extends CartEvent {
  final int productId;
  final int quantity;
  AddOrRemoveCartEvent({
    required this.productId,
    required this.quantity,
  });
  @override
  List<Object> get props => [productId, quantity];
}

class DeleteCartEvent extends CartEvent {
  final int productId;
  const DeleteCartEvent({
    required this.productId,
  });
}

class UpdateCartEvent extends CartEvent {
  final int productId;
  final int quantity;
  const UpdateCartEvent({
    required this.productId,
    required this.quantity,
  });
}
