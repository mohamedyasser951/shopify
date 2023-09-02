import 'package:bloc/bloc.dart';
import 'package:commerceapp/Config/Network/error_strings.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_model.dart';
import 'package:equatable/equatable.dart';

import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/repositories/order_repo.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrderRepo orderRepo;
  OrdersModel? ordersModel;
  OrdersBloc({
    required this.orderRepo,
  }) : super(OrdersInitial()) {
    on<OrdersEvent>((event, emit) async {
      if (event is GetAllOrdersEvent) {
        emit(GetAllOrdersLoadingState());
        var ordersOrFailure = await orderRepo.getAllOrders();
        ordersOrFailure.fold(
            (failure) => emit(
                GetAllOrdersErrorState(message: mapFailureToMessage(failure))),
            (orders) {
          ordersModel = orders;
          print(orders);
          emit(GetAllOrdersSuccessState());
        });
      }
    });
  }
}
