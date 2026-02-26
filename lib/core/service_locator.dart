import 'package:application/core/app_preferences.dart';
import 'package:application/core/database/app_database.dart';
import 'package:application/features/category_listing/data/datasource/category_local_data_source.dart';
import 'package:application/features/category_listing/data/datasource/category_local_data_source_impl.dart';
import 'package:application/features/category_listing/data/datasource/category_remote_data_source.dart';
import 'package:application/features/category_listing/data/datasource/category_remote_data_source_impl.dart';
import 'package:application/features/category_listing/data/repository/category_repository_impl.dart';
import 'package:application/features/category_listing/domain/repository/category_repository.dart';
import 'package:application/features/category_listing/domain/usecase/add_category_usecase.dart';
import 'package:application/features/category_listing/domain/usecase/category_usecase.dart';
import 'package:application/features/category_listing/domain/usecase/delete_category_usecase.dart';
import 'package:application/features/category_listing/domain/usecase/sync_category_usecase.dart';
import 'package:application/features/category_listing/presentation/bloc/category_bloc.dart';
import 'package:application/screens/dashboard/data/datasource/transaction_remote_datasource.dart';
import 'package:application/screens/dashboard/data/datasource/transaction_remote_datasource_impl.dart';
import 'package:application/screens/dashboard/data/repository/transaction_repository_impl.dart';
import 'package:application/screens/dashboard/domain/repository/transaction_repository.dart';
import 'package:application/screens/dashboard/domain/usecase/delete_transactions_usecase.dart';
import 'package:application/screens/dashboard/domain/usecase/get_transactions_usecase.dart';
import 'package:application/screens/dashboard/domain/usecase/sync_transactions_usecase.dart';
import 'package:application/screens/dashboard/presentation/bloc/transaction_bloc.dart';
import 'package:application/screens/login/presentation/cubit/otp_timer_cubit.dart';
import 'package:application/screens/name_page/data/datasource/name_remote_data_source.dart';
import 'package:application/screens/name_page/data/datasource/name_remote_data_source_impl.dart';
import 'package:application/screens/name_page/data/repository/name_repository_impl.dart';
import 'package:application/screens/name_page/domain/repository/name_repository.dart';
import 'package:application/screens/name_page/domain/usecase/name_usecase.dart';
import 'package:application/screens/name_page/presentation/bloc/name_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:application/core/network/dio_client.dart';
import 'package:application/screens/login/data/auth_remote_datasource.dart';
import 'package:application/screens/login/data/auth_remote_datasource_impl.dart';
import 'package:application/screens/login/data/auth_repository_impl.dart';
import 'package:application/screens/login/domain/auth_repository.dart';
import 'package:application/screens/login/domain/auth_usecase.dart';
import 'package:application/screens/login/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
final sl = GetIt.instance;

Future<void> init() async {

  /// 🔥 DATABASE (VERY IMPORTANT)
  // final database = await AppDatabase.database;

  // sl.registerLazySingleton<Database>(() => database);

  /// ======================================================
  /// 🔵 CORE
  /// ======================================================

  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<AppPreferences>(
    () => AppPreferences(prefs),
  );

  sl.registerLazySingleton<Dio>(() => DioClient.dio);

  /// ======================================================
  /// 🟢 AUTH
  /// ======================================================

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(
    () => SendOtpUseCase(sl()),
  );

  sl.registerFactory(
    () => AuthBloc(
      sendOtpUseCase: sl(),
      appPreferences: sl(),
    ),
  );

  sl.registerFactory(() => OtpTimerCubit());

  /// ======================================================
  /// 🟡 NAME (CREATE ACCOUNT)
  /// ======================================================

  sl.registerLazySingleton<NameRemoteDataSource>(
    () => NameRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<NameRepository>(
    () => NameRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(
    () => NameUsecase(sl()),
  );

  sl.registerFactory(
    () => NameBloc(
      createAccountUseCase: sl(),
      appPreferences: sl(),
    ),
  );

  /// ======================================================
  /// 🟠 TRANSACTIONS
  /// ======================================================

  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(
    () => GetTransactionsUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => SyncTransactionsUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => DeleteTransactionsUseCase(sl()),
  );

  sl.registerFactory(
    () => TransactionBloc(
      getTransactionsUseCase: sl(),
      syncTransactionsUseCase: sl(),
      deleteTransactionsUseCase: sl(),
    ),
  );

  /// ======================================================
  /// 🟣 CATEGORIES
  /// ======================================================

  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      local: sl(),
      remote: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetCategoriesUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => AddCategoryUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => DeleteCategoryUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => SyncCategoryUseCase(sl()),
  );

  sl.registerFactory(
    () => CategoryBloc(
      getCategoriesUseCase: sl(),
      addCategoryUseCase: sl(),
      deleteCategoryUseCase: sl(),
      syncCategoryUseCase: sl(),
    ),
  );
}