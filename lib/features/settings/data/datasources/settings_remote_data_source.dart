import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/Network/exception.dart';
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
    if (response.statusCode == 200) {
      return AddressesModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
