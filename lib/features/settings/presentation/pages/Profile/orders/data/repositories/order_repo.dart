import 'package:commerceapp/Config/Network/failure.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/dataSource/orders_reomte_data_source.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_details_model.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class OrderRepo {
  Future<Either<Failure, OrdersModel>> getAllOrders();
  Future<Either<Failure, OrdersDetailsModel>> getOrdersDetails(
      {required int id});
  Future<Either<Failure, OrdersDetailsModel>> cancelOrder({required int id});
  Future<Either<Failure, OrdersDetailsModel>> addOrder({required int id});
}

class OrderRepoImplement implements OrderRepo {
  OrdersRemoteDataSource remoteDataSource;
  InternetChecker internetChecker;
  OrderRepoImplement({
    required this.remoteDataSource,
    required this.internetChecker,
  });
  @override
  Future<Either<Failure, OrdersModel>> getAllOrders() async {
    try {
      OrdersModel orders = await remoteDataSource.getAllOrders();
      return Right(orders);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrdersDetailsModel>> addOrder(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        OrdersDetailsModel order = await remoteDataSource.addOrder(id: id);
        return Right(order);
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
  Future<Either<Failure, OrdersDetailsModel>> cancelOrder(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        OrdersDetailsModel order = await remoteDataSource.cancelOrder(id: id);
        return Right(order);
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
  Future<Either<Failure, OrdersDetailsModel>> getOrdersDetails(
      {required int id}) async {
    if (await internetChecker.isConnected) {
      try {
        OrdersDetailsModel orderdetails =
            await remoteDataSource.getOrdersDetails(id: id);
        return Right(orderdetails);
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
