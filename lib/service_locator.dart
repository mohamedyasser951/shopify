import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    receiveDataWhenStatusError: true);
GetIt sl = GetIt.instance;
Future<void> init() async {
  //BLOCS
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepo: sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(homeRepo: sl()));

  //Repositories
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImplem(internetChecker: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImplem(dataSource: sl()),
  );

  //DataSource
  sl.registerLazySingleton(
    () => HomeRemoteDataSource(dio: sl()),
  );
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(
      dio: sl(),
    ),
  );

// Core
  sl.registerLazySingleton<InternetChecker>(
    () => InternetCheckerimplem(),
  );

  //External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
