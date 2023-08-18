import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/Network/exception.dart';
import 'package:commerceapp/features/home/data/models/card_model.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  Dio dio;
  HomeRemoteDataSource({
    required this.dio,
  });

  Map<String, String> header = {
    "lang": "ar",
    "Content-Type": "application/json",
    "Authorization":
        "GsRvI0dJWA7OdqG1rDgqPtsQyGx8VME4bJWH7keIc9mwSNjKqxwnTySyu9fdyx08ZwWXlc"
  };

  Future<HomeModel> getHomeData() async {
    var response = await dio.get(EndPoints.home);
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<CategoryModel> getCategories() async {
    var response = await dio.get(EndPoints.category);
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<FavoriteModel> getFavorites() async {
    var response = await dio.get(EndPoints.favorites,
        options: Options(headers: {
          "lang": "ar",
          "Content-Type": "application/json",
          "Authorization":
              "WfIA5OJkBvu1rgRgL3vI5UBuHNNnF1vvBKNpsM1vDpldLqHofMe85oV27uVSTVNyypQRCs"
        }));
    if (response.statusCode == 200) {
      return FavoriteModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<CardModel> getCard() async {
    Response response =
        await dio.get(EndPoints.carts, options: Options(headers: header));
    if (response.statusCode == 200) {
      return CardModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<FavoriteModel> setOrDeleteFromFavorites({required int id}) async {
    var response = await dio.post(EndPoints.favorites,
        data: {"product_id": id}, options: Options(headers: header));
    if (response.statusCode == 200) {
      return FavoriteModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
