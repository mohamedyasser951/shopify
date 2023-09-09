import 'package:commerceapp/Config/Network/exception.dart';
import 'package:dartz/dartz.dart';

import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/home/features/cart/data/datasources/cartRemoteDataSource.dart';

abstract class CartRepo {
  Future<Either<Failure, CardModel>> getCarts();
  Future<Either<Failure, Map<String, dynamic>>> addOrDeleteFromCats(
      {required int productId});
  Future<Either<Failure, Unit>> updateCart({required int productId});
  Future<Either<Failure, Unit>> deleteCart({required int productId});
}

class CartRepoImplem implements CartRepo {
  CartRemoteDataSource remoteDataSource;
  InternetChecker internetChecker;

  CartRepoImplem({
    required this.remoteDataSource,
    required this.internetChecker,
  });
  @override
  Future<Either<Failure, CardModel>> getCarts() async {
    try {
      CardModel cardModel = await remoteDataSource.getCarts();
      return Right(cardModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addOrDeleteFromCats(
      {required int productId}) async {
    if (await internetChecker.isConnected) {
      try {
        var data =
            await remoteDataSource.addOrDeleteFromCats(productId: productId);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCart({required int productId}) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateCart({required int productId}) {
    // TODO: implement updateCart
    throw UnimplementedError();
  }
}
