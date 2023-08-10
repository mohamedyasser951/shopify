import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/models/home_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, HomeModel>> getHomeData();
}

class HomeRepoImplem implements HomeRepo {
  HomeRemoteDataSource dataSource;

  HomeRepoImplem({required this.dataSource});
  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      var homeModel = await dataSource.getHomeData();
      return Right(homeModel);
    } on ServerFailure {
      return Left(ServerFailure());
    }
  }
}
