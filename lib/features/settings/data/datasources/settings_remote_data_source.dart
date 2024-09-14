import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/Network/exception.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/data.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/settings/data/models/addresses_data.dart';
import 'package:dio/dio.dart';

class SettingsRemoteDataSource {
  Dio dio;
  SettingsRemoteDataSource({
    required this.dio,
  });

  Future<AddressesModel> getAdresses() async {
    Response response =
        await dio.get(EndPoints.adresses, options: Options(headers: header));
    if (response.statusCode == 200) {
      return AddressesModel.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }

  Future<AddressesModel> addAdresses({
    required AddressData addressData,
  }) async {
    print("address Details ${addressData.details}");
    Response response = await dio.post(EndPoints.adresses,
        data: {
          "name": addressData.name,
          "city": addressData.city,
          "region": addressData.region,
          "details": addressData.details,
          "notes": addressData.notes,
          "latitude": 30.0616863,
          "longitude": 31.3260088
        },
        options: Options(
          headers: header,
        ));
    // if (response.statusCode == 200) {
    //   print("success 2000");
    //   print(response.data);
    return AddressesModel.fromJsonAsModel(response.data);
    // }
    //  else {
    //   throw ServerException();
    // }
  }

  Future<UserModel> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    Map body = {
      "current_password": currentPassword,
      "new_password": newPassword,
    };
    Response response = await dio.post(EndPoints.changePassword,
        data: body,
        options: Options(
          headers: header,
        ));
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<UserModel> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String image,
  }) async {
    Map body = {"name": name, "email": email, "phone": phone, "image": ""};
    Response response = await dio.put(EndPoints.updateProfile,
        data: body,
        options: Options(
          headers: header,
        ));
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<UserData> getUserProfile() async {
    Response response =
        await dio.get(EndPoints.profile, options: Options(headers: header));
    if (response.statusCode == 200) {
      return UserData.fromJson(response.data["data"]);
    } else {
      throw ServerException();
    }
  }
}
