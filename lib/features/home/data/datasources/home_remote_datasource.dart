import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/favorites/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:dio/dio.dart';

Map<String, String> header = {
  "lang": "en",
  "Content-Type": "application/json",
  "Authorization": TOKEN!
};

class HomeRemoteDataSource {
  Dio dio;
  HomeRemoteDataSource({
    required this.dio,
  });

  Future<HomeModel> getHomeData() async {
    var response =
        await dio.get(EndPoints.home, options: Options(headers: header));
    return HomeModel.fromJson(response.data);
  }

  Future<CategoryModel> getCategories() async {
    var response =
        await dio.get(EndPoints.category, options: Options(headers: header));
    return CategoryModel.fromJson(response.data);
  }

  Future<List<Products>> getCategoriesDetails({required int id}) async {
    List<Products> products = [];
    var response = await dio.get("${EndPoints.category}/$id",
        options: Options(headers: header));
    response.data["data"]["data"].forEach((element) {
      products.add(Products.fromJson(element));
    });
    return products;
  }

  Future<FavoriteModel> getFavorites() async {
    var response =
        await dio.get(EndPoints.favorites, options: Options(headers: header));
    return FavoriteModel.fromJson(response.data);
  }

  Future<FavoriteModel> setOrDeleteFromFavorites({required int id}) async {
    var response = await dio.post(EndPoints.favorites,
        data: {"product_id": id}, options: Options(headers: header));
    return FavoriteModel.fromJson(response.data);
  }

  Future<List<Products>> search({required String text}) async {
    Response response = await dio.post(EndPoints.search,
        data: {"text": text}, options: Options(headers: header));
    List<Products> searchResult = [];
    response.data["data"]["data"].forEach((product) {
      searchResult.add(Products.fromJson(product));
    });
    return searchResult;
  }

  // Future<UserData> getUserProfile() async {
  //   Response response =
  //       await dio.get(EndPoints.profile, options: Options(headers: header));
  //   if (response.statusCode == 200) {
  //     return UserData.fromJson(response.data["data"]);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // Future<UserModel> updateProfile({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String image,
  // }) async {
  //   Map body = {"name": name, "email": email, "phone": phone, "image": ""};
  //   Response response = await dio.put(EndPoints.updateProfile,
  //       data: body,
  //       options: Options(
  //         headers: header,
  //       ));
  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(response.data);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // Future<UserModel> changePassword({
  //   required String currentPassword,
  //   required String newPassword,
  // }) async {
  //   Map body = {
  //     "current_password": currentPassword,
  //     "new_password": newPassword,
  //   };
  //   Response response = await dio.post(EndPoints.changePassword,
  //       data: body,
  //       options: Options(
  //         headers: header,
  //       ));
  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(response.data);
  //   } else {
  //     throw ServerException();
  //   }
  // }
}
