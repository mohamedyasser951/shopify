import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/Network/exception.dart';
import 'package:commerceapp/Config/constants/strings.dart';
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
    "lang": "en",
    "Content-Type": "application/json",
    "Authorization": TOKEN!
  };

  Future<HomeModel> getHomeData() async {
    var response =
        await dio.get(EndPoints.home, options: Options(headers: header));
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<CategoryModel> getCategories() async {
    var response = await dio.get(EndPoints.category, options: Options(headers: header));
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<FavoriteModel> getFavorites() async {
    var response =
        await dio.get(EndPoints.favorites, options: Options(headers: header));
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

  Future<List<Products>> search({required String text}) async {
    Response response = await dio.post(EndPoints.search,
        data: {"text": text}, options: Options(headers: header));
    if (response.statusCode == 200) {
      List<Products> searchResult = [];
      response.data["data"]["data"].forEach((product) {
        searchResult.add(Products.fromJson(product));
      });
      return searchResult;
    } else {
      throw ServerException();
    }
  }
}
