import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/features/cart/data/models/message_card_model.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:commerceapp/features/cart/data/models/card_model.dart';
import 'package:dio/dio.dart';

class CartRemoteDataSourceImplem implements CartRemoteDataSource {
  Dio dio;
  CartRemoteDataSourceImplem({
    required this.dio,
  });

  @override
  Future<CartModel> getCarts() async {
    Response response =
        await dio.get(EndPoints.carts, options: Options(headers: header));
    return CartModel.fromJson(response.data);
  }

  @override
  Future<ResultCardModel> addOrDeleteFromCats({required int productId}) async {
    Response response = await dio.post(EndPoints.carts,
        data: {"product_id": productId}, options: Options(headers: header));
    print(response.data);
    return ResultCardModel.fromJson(response.data);
  }

  @override
  Future<ResultCardModel> deleteCart({required int productId}) async {
    Response response = await dio.delete("${EndPoints.carts}/$productId",
        options: Options(headers: header));
    print(response.data);
    return ResultCardModel.fromJson(response.data);
  }

  @override
  Future<ResultCardModel> updateCart(
      {required int productId, required int quantity}) async {
    Response response = await dio.put("${EndPoints.carts}/$productId",
        data: {"quantity": quantity}, options: Options(headers: header));

    print(response.data);
    return ResultCardModel.fromJson(response.data);
  }
}
