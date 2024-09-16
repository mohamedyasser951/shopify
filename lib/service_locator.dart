import 'package:commerceapp/Config/Network/interceptors.dart';
import 'package:commerceapp/Config/Network/internet_checker.dart';
import 'package:commerceapp/features/Auth/data/datasources/remote_data_source.dart';
import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/categories/presentation/cubit/categories_details_cubit.dart';
import 'package:commerceapp/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:commerceapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo_implem.dart';
import 'package:commerceapp/features/cart/data/datasources/cart_data_source_implem.dart';
import 'package:commerceapp/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:commerceapp/features/cart/data/repositories/cart_repo.dart';
import 'package:commerceapp/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:commerceapp/features/layout/cubits/bottom_cubit/bottom_nav_cubit.dart';
import 'package:commerceapp/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:commerceapp/features/settings/data/repositories/settings_repo.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/dataSource/orders_reomte_data_source.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/repositories/order_repo.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/presentation/bloc/orders_bloc.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

BaseOptions options = BaseOptions(
  connectTimeout: const Duration(seconds: 5 * 6000),
  receiveTimeout: const Duration(seconds: 5 * 6000),
  receiveDataWhenStatusError: true,
);

GetIt sl = GetIt.instance;
Future<void> init() async {
  //BLOCS
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepo: sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(homeRepo: sl()));
  sl.registerFactory<CategoriesDetailsCubit>(
      () => CategoriesDetailsCubit(homeRepo: sl()));
  sl.registerFactory<FavoritesBloc>(() => FavoritesBloc(homeRepo: sl()));

  sl.registerFactory<SettingsBloc>(() => SettingsBloc(settingsRepo: sl()));
  sl.registerFactory<OrdersBloc>(() => OrdersBloc(orderRepo: sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(cartRepo: sl()));
  sl.registerFactory<BottomNavCubit>(() => BottomNavCubit());

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
  Dio dio = Dio(options);
  dio.interceptors.add(RetryInterceptor(
    maxRetries: 3, // Number of retries
    retryInterval: Duration(seconds: 2), // Interval between retries
  ));
  sl.registerLazySingleton<Dio>(() => dio);
  // sl.registerLazySingleton(() => InternetConnectionChecker());
}
