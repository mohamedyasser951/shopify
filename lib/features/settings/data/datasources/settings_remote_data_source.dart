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
}
