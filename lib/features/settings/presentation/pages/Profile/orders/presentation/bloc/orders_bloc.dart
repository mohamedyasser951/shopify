import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_details_model.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_model.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/repositories/order_repo.dart';
import 'package:equatable/equatable.dart';
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
            (failure) => emit(GetAllOrdersErrorState(message: failure.message)),
            (orders) {
          ordersModel = orders;
          emit(GetAllOrdersSuccessState());
        });
      }
      if (event is GetOrdersDetailsEvent) {
        emit(GetOrderDetailLoadingState());
        var ordersOrFailure = await orderRepo.getOrdersDetails(id: event.id);
        ordersOrFailure.fold(
            (failure) =>
                emit(GetOrderDetailErrorState(message: failure.message)),
            (orderdetails) {
          emit(GetOrderDetailSuccessState(ordersDetailsModel: orderdetails));
        });
      }
    });
  }
}
