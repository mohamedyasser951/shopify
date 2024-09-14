import 'package:commerceapp/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:commerceapp/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/cart/data/models/message_card_model.dart';
import 'package:dartz/dartz.dart';
import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:dio/dio.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getAllCarts();
  Future<Either<Failure, ResultCardModel>> addOrDeleteFromCats(
      {required int productId});
  Future<Either<Failure, ResultCardModel>> updateCart(
      {required int productId, required int quantity});
  Future<Either<Failure, ResultCardModel>> deleteCart({required int productId});
}

class CartRepoImplem implements CartRepo {
  CartRemoteDataSource remoteDataSource;
  InternetChecker internetChecker;

  CartRepoImplem({
    required this.remoteDataSource,
    required this.internetChecker,
  });
  @override
  Future<Either<Failure, CartModel>> getAllCarts() async {
    try {
      CartModel cardModel = await remoteDataSource.getCarts();
      return Right(cardModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultCardModel>> addOrDeleteFromCats(
      {required int productId}) async {
    if (await internetChecker.isConnected) {
      try {
        var data =
            await remoteDataSource.addOrDeleteFromCats(productId: productId);
        return Right(data);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure("Please Check your Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, ResultCardModel>> deleteCart(
      {required int productId}) async {
    if (await internetChecker.isConnected) {
      try {
        var data = await remoteDataSource.deleteCart(productId: productId);
        return Right(data);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure("Please Check your Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, ResultCardModel>> updateCart(
      {required int productId, required int quantity}) async {
    if (await internetChecker.isConnected) {
      try {
        var data = await remoteDataSource.updateCart(
            productId: productId, quantity: quantity);
        return Right(data);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure.fromDiorError(e));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure("Please Check your Internet Connection"));
    }
  }
}
