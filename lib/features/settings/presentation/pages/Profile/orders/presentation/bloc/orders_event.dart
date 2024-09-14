part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class GetAllOrdersEvent extends OrdersEvent {}

class GetOrdersDetailsEvent extends OrdersEvent {
  final int id;
  const GetOrdersDetailsEvent({
    required this.id,
  });
}

class AddOrderEvent extends OrdersEvent {
  final int id;
  const AddOrderEvent({
    required this.id,
  });
}

class CancelOrderEvent extends OrdersEvent {
  final int id;
  const CancelOrderEvent({
    required this.id,
  });
}
