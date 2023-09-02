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
