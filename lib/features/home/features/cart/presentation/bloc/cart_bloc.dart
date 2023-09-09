import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:commerceapp/Config/Network/error_strings.dart';
import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/home/features/cart/data/repositories/cartRepo.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;
  CardModel? cartModel;
  late Map<int, bool> inCards;

  CartBloc({
    required this.cartRepo,
    required this.inCards,
  }) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetCardEvent) {
        emit(GetCardLoadingState());
        var failureOrData = await cartRepo.getCarts();
        failureOrData.fold(
            (failure) =>
                emit(GetCardSErrorState(error: mapFailureToMessage(failure))),
            (model) {
          cartModel = model;
          emit(GetCardSuceessState());
        });
      }
      if (event is AddOrDeleteFromCartEvent) {
        inCards[event.productId] = !inCards[event.productId]!;
        emit(ChangeStateOfCarts());
        var failureOrData =
            await cartRepo.addOrDeleteFromCats(productId: event.productId);
        failureOrData.fold((failure) {
          inCards[event.productId] = !inCards[event.productId]!;

          emit(AddOrDeleteErrorState(error: mapFailureToMessage(failure)));
        }, (data) {
          if (data["status"] != true) {
            inCards[event.productId] = !inCards[event.productId]!;
          } else {
            add(GetCardEvent());
          }
          emit(AddOrDeleteSuccessState(successMessage: data["message"]));
        });
      }
    });
  }
}
