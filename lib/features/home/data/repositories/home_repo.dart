import 'package:commerceapp/features/home/data/models/card_model.dart';
import 'package:dartz/dartz.dart';
import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, HomeModel>> getHomeData();
  Future<Either<Failure, CategoryModel>> getCategories();
  Future<Either<Failure, CardModel>> getCard();
  Future<Either<Failure, FavoriteModel>> getFavorites();
  Future<Either<Failure, FavoriteModel>> setOrDeleteFromFavorites(
      {required int id});
}

class HomeRepoImplem implements HomeRepo {
  HomeRemoteDataSource dataSource;
  InternetChecker internetChecker;

  HomeRepoImplem({
    required this.dataSource,
    required this.internetChecker,
  });

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      var homeModel = await dataSource.getHomeData();
      return Right(homeModel);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategories() async {
    try {
      var categoryModel = await dataSource.getCategories();
      return Right(categoryModel);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> getFavorites() async {
    try {
      var favorites = await dataSource.getFavorites();
      return Right(favorites);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> setOrDeleteFromFavorites(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        var favorite = await dataSource.setOrDeleteFromFavorites(id: id);
        return Right(favorite);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      throw OfflineFailure();
    }
  }

  @override
  Future<Either<Failure, CardModel>> getCard() async {
    try {
      var cardModel = await dataSource.getCard();
      return Right(cardModel);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
