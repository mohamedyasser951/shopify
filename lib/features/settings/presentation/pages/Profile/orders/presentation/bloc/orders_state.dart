part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

//Get All Orders

class GetAllOrdersLoadingState extends OrdersState {}

class GetAllOrdersErrorState extends OrdersState {
  final String message;
  const GetAllOrdersErrorState({
    required this.message,
  });
}

class GetAllOrdersSuccessState extends OrdersState {}

// Get Orders Details
class GetOrderDetailLoadingState extends OrdersState {}

class GetOrderDetailSuccessState extends OrdersState {
  final OrdersDetailsModel ordersDetailsModel;
  const GetOrderDetailSuccessState({
    required this.ordersDetailsModel,
  });
}

class GetOrderDetailErrorState extends OrdersState {
  final String message;
  const GetOrderDetailErrorState({
    required this.message,
  });
}
