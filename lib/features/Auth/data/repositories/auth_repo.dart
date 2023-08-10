import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

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
  AuthRepoImplem({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> userLogin(
      {required String email, required String password}) async {
    try {
      final userModel =
          await remoteDataSource.userLogin(email: email, password: password);
      return Right(userModel);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      UserModel userModel = await remoteDataSource.userRegister(
          name: name, email: email, phone: phone, password: password);
      return Right(userModel);
    } on ServerFailure {
      return left(ServerFailure());
    }
  }
}
