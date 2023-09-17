import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/features/home/features/cart/data/repositories/cartRepo.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;
  // CardModel? cartModel;
 
  CartBloc({
    required this.cartRepo,
   
  }) : super(CartInitial()) {

    on<CartEvent>((event, emit) async {
      // if (event is GetCardEvent) {
      //   emit(GetCardLoadingState());
      //   var failureOrData = await cartRepo.getCarts();
      //   failureOrData.fold(
      //       (failure) =>
      //           emit(GetCardSErrorState(error: mapFailureToMessage(failure))),
      //       (model) {
      //     emit(GetCardSuceessState(cardData: model.data!));
      //   });
      // }
      // if (event is AddOrDeleteFromCartEvent) {
      //   inCards[event.productId] = !inCards[event.productId]!;
      //   emit(ChangeStateOfCarts());
      //   var failureOrData =
      //       await cartRepo.addOrDeleteFromCats(productId: event.productId);
      //   failureOrData.fold((failure) {
      //     inCards[event.productId] = !inCards[event.productId]!;

      //     emit(AddOrDeleteErrorState(error: mapFailureToMessage(failure)));
      //   }, (data) {
      //     if (data["status"] != true) {
      //       inCards[event.productId] = !inCards[event.productId]!;
      //     } else {
      //       add(GetCardEvent());
      //     }
      //     emit(AddOrDeleteSuccessState(successMessage: data["message"]));
      //   });
      // }
      // if (event is DeleteCartEvent) {
      //   var failureOrData =
      //       await cartRepo.deleteCart(productId: event.productId);

      //   failureOrData.fold(
      //       (failure) =>
      //           emit(GetCardSErrorState(error: mapFailureToMessage(failure))),
      //       (data) {
      //     if (data["status"] == true) {
      //       add(GetCardEvent());
      //     }
      //     // emit(DeleteCartSuccessState());
      //   });
      // }
      if (event is UpdateCartEvent) {
        // var failureOrData = await cartRepo.updateCart(
        //     productId: event.productId, quantity: event.quantity);

        // failureOrData.fold(
        //     (failure) =>
        //         emit(UpdateCartErrorState(error: mapFailureToMessage(failure))),
        //     (data) {
        //   if (data["status"] == true) {
        //     quantiy = data["quantity"];
        //     total = data["total"];
        //     add(GetCardEvent());
        //   }
        //   // emit(UpdateCartSuccessState());
        // });
      }
    });
  }
}
