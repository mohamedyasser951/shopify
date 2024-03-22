import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';
import 'package:dio/dio.dart';

class CartRemoteDataSourceImplem implements CartRemoteDataSource {
  Dio dio;
  CartRemoteDataSourceImplem({
    required this.dio,
  });

  @override
  Future<CardModel> getCarts() async {
    Response response =
        await dio.get(EndPoints.carts, options: Options(headers: header));
    return CardModel.fromJson(response.data);
  }

  @override
  Future<Map<String, dynamic>> addOrDeleteFromCats(
      {required int productId}) async {
    Response response = await dio.post(EndPoints.carts,
        data: {"product_id": productId}, options: Options(headers: header));
    Map<String, dynamic> data = {
      "status": response.data["status"],
      "message": response.data["message"],
    };
    return Future.value(data);
  }

  @override
  Future<Map<String, dynamic>> deleteCart({required int productId}) async {
    Response response = await dio.delete("${EndPoints.carts}/$productId");
    Map<String, dynamic> data = {
      "status": response.data["status"],
      "total": response.data["total"],
    };
    return data;
  }

  @override
  Future<Map<String, dynamic>> updateCart(
      {required int productId, required int quantity}) async {
    Response response = await dio
        .put("${EndPoints.carts}/$productId", data: {"quantity": quantity});
    Map<String, dynamic> data = {
      "status": response.data["status"],
      "quantity": response.data["quantity"],
      "total": response.data["total"],
    };
    return data;
  }
}