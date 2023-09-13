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
