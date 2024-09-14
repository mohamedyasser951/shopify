import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/cart/data/models/card_model.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/cart/data/repositories/cart_repo.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;
  late CardData cartdata;
  CartBloc({
    required this.cartRepo,
  }) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetAllCarts) {
        emit(CartInitial());
        var failureOrData = await cartRepo.getAllCarts();
        failureOrData.fold((failure) {
          emit(CartErrorState(error: failure.message));
        }, (data) {
          cartdata = data.data!;
          emit(CartLoaddedState(cartdata: data.data!));
        });
      }
      if (event is AddOrRemoveCartEvent) {
        var failureOrData =
            await cartRepo.addOrDeleteFromCats(productId: event.productId);
        failureOrData.fold((failure) {
          emit(CartErrorState(error: failure.message));
        }, (data) {
          print(data);
          add(GetAllCarts());
        });
      }
      if (event is UpdateCartEvent) {
        var failureOrData = await cartRepo.updateCart(
            productId: event.productId, quantity: event.quantity);
        failureOrData.fold((failure) {
          emit(CartErrorState(error: failure.message));
        }, (data) {
          final item = cartdata.cartItems!.firstWhere(
            (cartItem) => cartItem.id == event.productId,
          );
          if (item.product != null && event.quantity > 0) {
            item.quantity = event.quantity;
          } 
          else if (item.product != null && event.quantity <= 0) {
            add(DeleteCartEvent(productId: event.productId));
          }
          emit(CartLoaddedState(
              cartdata: CardData(
                  cartItems:cartdata.cartItems ,
                  subTotal: data.data!.subTotal,
                  total: data.data!.total)));
        });
      }
      if (event is DeleteCartEvent) {
        var failureOrData =
            await cartRepo.deleteCart(productId: event.productId);
        failureOrData.fold((failure) {
          emit(CartErrorState(error: failure.message));
        }, (data) {
          cartdata.cartItems!.removeWhere((item) => item.id == event.productId);
          emit(CartLoaddedState(
              cartdata: CardData(
                  cartItems: cartdata.cartItems,
                  subTotal: data.data!.subTotal,
                  total: data.data!.total)));
        });
      }
    });
  }
}


