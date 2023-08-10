import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    receiveDataWhenStatusError: true);
GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplem(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => HomeRepoImplem(dataSource: sl()),
  );

  sl.registerLazySingleton(
    () => AuthRemoteDataSource(dio: sl()),
  );

  sl.registerLazySingleton(
    () => HomeRemoteDataSource(dio: sl()),
  );



  sl.registerLazySingleton(() => Dio());
}
