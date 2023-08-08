import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplem(dio: sl()),
  );

  sl.registerLazySingleton(() => Dio());
}
