import 'package:commerceapp/features/Auth/data/models/user_model/data.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:commerceapp/features/home/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:commerceapp/features/home/features/settings/data/models/addresses_data.dart';
import 'package:dartz/dartz.dart';
import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';

import 'package:dio/dio.dart';

abstract class SettingsRepo {
  Future<Either<Failure, AddressesModel>> getAdresses();
  Future<Either<Failure, AddressesModel>> addAdresses(
      {required AddressData addressData});

  Future<Either<Failure, UserData>> getUserProfile();

  Future<Either<Failure, UserModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String image,
  });

  Future<Either<Failure, UserModel>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
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
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressesModel>> addAdresses(
      {required AddressData addressData}) async {
    try {
      var addresses =
          await remoteDataSource.addAdresses(addressData: addressData);

      return Right(addresses);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> changePassword(
      {required String currentPassword, required String newPassword}) async {
    if (await internetChecker.isConnected) {
      try {
        var data = await remoteDataSource.changePassword(
            currentPassword: currentPassword, newPassword: newPassword);
        return Right(data);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    } else {
       return Left(OfflineFailure("Please Check your Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserProfile() async {
    try {
      var data = await remoteDataSource.getUserProfile();
      return Right(data);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(
      {required String name,
      required String email,
      required String phone,
      required String image}) async {
    if (await internetChecker.isConnected) {
      try {
        var data = await remoteDataSource.updateProfile(
            name: name, email: email, phone: phone, image: image);
        return Right(data);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return left(ServerFailure(e.toString()));
      }
    } else {
       return Left(OfflineFailure("Please Check your Internet Connection"));
    }
  }
}
