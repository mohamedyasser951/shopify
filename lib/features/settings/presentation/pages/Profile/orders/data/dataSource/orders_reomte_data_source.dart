import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_details_model.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_model.dart';
import 'package:dio/dio.dart';

class OrdersRemoteDataSource {
  Dio dio;
  OrdersRemoteDataSource({
    required this.dio,
  });
  Future<OrdersModel> getAllOrders() async {
    Response response =
        await dio.get(EndPoints.orders, options: Options(headers: header));
    return OrdersModel.fromJson(response.data);
  }

  Future<OrdersDetailsModel> getOrdersDetails({required int id}) async {
    Response response = await dio.get("${EndPoints.orders}/$id",
        options: Options(headers: header));
    return OrdersDetailsModel.fromJson(response.data);
  }

  Future<OrdersDetailsModel> cancelOrder({required int id}) async {
    Response response = await dio.get("${EndPoints.orders}/$id/cancel",
        options: Options(headers: header));
    return OrdersDetailsModel.fromJson(response.data);
  }

  Future<OrdersDetailsModel> addOrder({required int id}) async {
    Response response = await dio.post(EndPoints.orders,
        data: {
          "address_id": "",
          "payment_method": "",
          "use_points": "",
        },
        options: Options(headers: header));
    return OrdersDetailsModel.fromJson(response.data);
  }
}
