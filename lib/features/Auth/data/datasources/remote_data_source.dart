import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/Network/exception.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource({
    required this.dio,
  });

  Future<UserModel> userLogin(
      {required String email, required String password}) async {
    var response = await dio.post(EndPoints.login,
        options: Options(headers: {
          "Content-Type": "application/json",
          "lang": "en",
        }),
        data: {"email": email, "password": password});
    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    } else {
      throw ServerException();
    }
  }

  Future<UserModel> userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    var response = await dio.post(EndPoints.register,
        options: Options(headers: {
          "Content-Type": "application/json",
          "lang": "en",
        }),
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone
        });
    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    } else {
      throw ServerException();
    }
  }
}
