import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    receiveDataWhenStatusError: true);
GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplem(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => AuthRemoteDataSource(dio: sl()),
  );

  sl.registerLazySingleton(() => Dio());
}
