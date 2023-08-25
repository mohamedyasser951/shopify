import 'package:dartz/dartz.dart';

import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:commerceapp/features/settings/data/models/addresses_data.dart';

abstract class SettingsRepo {
  Future<Either<Failure, AddressesModel>> getAdresses();
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
}
