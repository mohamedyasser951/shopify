import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:dio/dio.dart';

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
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategories() async {
    try {
      var categoryModel = await dataSource.getCategories();
      return Right(categoryModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> getFavorites() async {
    try {
      var favorites = await dataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> setOrDeleteFromFavorites(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        var favorite = await dataSource.setOrDeleteFromFavorites(id: id);
        return Right(favorite);
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
  Future<Either<Failure, List<Products>>> search({required String text}) async {
    try {
      var searchResult = await dataSource.search(text: text);
      return Right(searchResult);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Products>>> getCategoriesDetails(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        var products = await dataSource.getCategoriesDetails(id: id);
        return Right(products);
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
