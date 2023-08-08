import 'package:commerceapp/Config/Network/end_points.dart';
import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthRepo {
  Future userRegister();
  Future<Either<Failure, UserModel>> userLogin({
    required String email,
    required String password,
  });
}

class AuthRepoImplem implements AuthRepo {
  final Dio dio;
  AuthRepoImplem({
    required this.dio,
  });

  @override
  Future<Either<Failure, UserModel>> userLogin(
      {required String email, required String password}) async {
    try {
      var response = await dio.post(EndPoints.login,
          options: Options(headers: {
            "Content-Type": "application/json",
            "lang": "ar",
          }),
          data: {"email": email, "password": password});

      UserModel userModel = UserModel.fromJson(response.data);
      return Right(userModel);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  Future userRegister() {
    // TODO: implement userRegister
    throw UnimplementedError();
  }
}
