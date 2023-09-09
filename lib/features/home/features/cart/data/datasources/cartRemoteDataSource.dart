import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';

abstract class CartRemoteDataSource {
  Future<CardModel> getCarts();
  Future<Map<String, dynamic>> addOrDeleteFromCats({required int productId});
  Future updateCart({required int productId});
  Future deleteCart({required int productId});
}
