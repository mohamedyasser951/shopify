import 'package:commerceapp/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/cart/data/models/result_card_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCarts();
  Future<ResultCardModel> addOrDeleteFromCats({required int productId});
  Future<ResultCardModel> updateCart(
      {required int productId, required int quantity});
  Future<ResultCardModel> deleteCart({required int productId});
}
