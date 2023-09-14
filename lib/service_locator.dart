import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo_implem.dart';
import 'package:commerceapp/features/home/features/cart/data/datasources/cartDataSourceImplem.dart';
import 'package:commerceapp/features/home/features/cart/data/datasources/cartRemoteDataSource.dart';
import 'package:commerceapp/features/home/features/cart/data/repositories/cartRepo.dart';
import 'package:commerceapp/features/home/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:commerceapp/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:commerceapp/features/settings/data/repositories/settings_repo.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/dataSource/orders_reomte_data_source.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/repositories/order_repo.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/bloc/orders_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 5*6000),
    receiveTimeout: const Duration(seconds: 5*6000),
    
    receiveDataWhenStatusError: true);

GetIt sl = GetIt.instance;
Future<void> init() async {
  //BLOCS
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepo: sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(homeRepo: sl()));
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(settingsRepo: sl()));
  sl.registerFactory<OrdersBloc>(() => OrdersBloc(orderRepo: sl()));
  sl.registerFactory<CartBloc>(
      () => CartBloc(cartRepo: sl(), inCards: sl<HomeBloc>().inCards));

  //Repositories
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImplem(internetChecker: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImplem(dataSource: sl(), internetChecker: sl()),
  );

  sl.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImplem(remoteDataSource: sl(), internetChecker: sl()),
  );
  sl.registerLazySingleton<OrderRepo>(
    () => OrderRepoImplement(remoteDataSource: sl(), internetChecker: sl()),
  );
  sl.registerLazySingleton<CartRepo>(
      () => CartRepoImplem(remoteDataSource: sl(), internetChecker: sl()));

  //DataSource
  sl.registerLazySingleton(
    () => HomeRemoteDataSource(dio: sl()),
  );
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(
      dio: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SettingsRemoteDataSource(dio: sl()),
  );
  sl.registerLazySingleton(
    () => OrdersRemoteDataSource(dio: sl()),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImplem(dio: sl()));

// Core
  sl.registerLazySingleton<InternetChecker>(
    () => InternetCheckerimplem(),
  );

  //External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
