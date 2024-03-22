import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';

abstract class CartRemoteDataSource {
  Future<CardModel> getCarts();
  Future<Map<String, dynamic>> addOrDeleteFromCats({required int productId});
  Future<Map<String, dynamic>> updateCart({required int productId,required int quantity});
  Future<Map<String, dynamic>> deleteCart({required int productId});
}
