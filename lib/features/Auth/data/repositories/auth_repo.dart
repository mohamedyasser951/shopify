import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';

@immutable
abstract class AuthRepo {
  Future userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
  Future<Either<Failure, UserModel>> userLogin({
    required String email,
    required String password,
  });
}

class AuthRepoImplem implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final InternetChecker internetChecker;
  AuthRepoImplem({
    required this.remoteDataSource,
    required this.internetChecker,
  });

  @override
  Future<Either<Failure, UserModel>> userLogin(
      {required String email, required String password}) async {
    if (await internetChecker.isConnected) {
      try {
        final userModel =
            await remoteDataSource.userLogin(email: email, password: password);
        return Right(userModel);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (await internetChecker.isConnected) {
      try {
        UserModel userModel = await remoteDataSource.userRegister(
            name: name, email: email, phone: phone, password: password);
        return Right(userModel);
      } on ServerFailure {
        return left(ServerFailure());
      }
    } else {
       return Left(OfflineFailure());
    }
  }
}
