import 'package:commerceapp/Config/Network/exception.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/data.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:commerceapp/features/home/data/models/card_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/models/category_model.dart';
import 'package:commerceapp/features/home/data/models/favorite_model.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';

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
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategories() async {
    try {
      var categoryModel = await dataSource.getCategories();
      return Right(categoryModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> getFavorites() async {
    try {
      var favorites = await dataSource.getFavorites();
      return Right(favorites);
    } on ServerException {
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
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, CardModel>> getCard() async {
    try {
      var cardModel = await dataSource.getCard();
      return Right(cardModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Products>>> search({required String text}) async {
    try {
      var searchResult = await dataSource.search(text: text);
      return Right(searchResult);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserData>> getUserProfile() async {
    try {
      var data = await dataSource.getUserProfile();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> changePassword(
      {required String currentPassword, required String newPassword}) async {
    if (await internetChecker.isConnected) {
      try {
        var data = await dataSource.changePassword(
            currentPassword: currentPassword, newPassword: newPassword);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
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
        var data = await dataSource.updateProfile(
            name: name, email: email, phone: phone, image: image);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Products>>> getCategoriesDetails(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        var products = await dataSource.getCategoriesDetails(id: id);
        return Right(products);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> setOrDeleteFromCart(
      {required int productId}) async {
    if (await internetChecker.isConnected) {
      try {
        var data = await dataSource.setOrDeleteFromCart(productId: productId);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
