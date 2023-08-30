import 'package:dartz/dartz.dart';

import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:commerceapp/features/settings/data/models/addresses_data.dart';

abstract class SettingsRepo {
  Future<Either<Failure, AddressesModel>> getAdresses();
  Future<Either<Failure, AddressesModel>> addAdresses(
      {required AddressData addressData});
}

class SettingsRepoImplem implements SettingsRepo {
  SettingsRemoteDataSource remoteDataSource;
  InternetChecker internetChecker;
  SettingsRepoImplem({
    required this.remoteDataSource,
    required this.internetChecker,
  });
  @override
  Future<Either<Failure, AddressesModel>> getAdresses() async {
    try {
      var addresses = await remoteDataSource.getAdresses();
      return Right(addresses);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AddressesModel>> addAdresses(
      {required AddressData addressData}) async {
    try {
      var addresses =
          await remoteDataSource.addAdresses(addressData: addressData);
      print(addresses.toString());
      print(addresses.status);
      print(addresses.message);
      print(addresses.data.toString());
      return Right(addresses);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
