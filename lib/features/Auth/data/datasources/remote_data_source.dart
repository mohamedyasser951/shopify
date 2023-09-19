import 'package:dio/dio.dart';
import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';

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
    UserModel userModel = UserModel.fromJson(response.data);
    return userModel;
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
    UserModel userModel = UserModel.fromJson(response.data);
    return userModel;
  }
}
