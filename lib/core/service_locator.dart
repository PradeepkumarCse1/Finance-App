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
final prefs = await SharedPreferences.getInstance();

sl.registerLazySingleton<AppPreferences>(
  () => AppPreferences(prefs),
);
  /// ✅ Dio (External)
  sl.registerLazySingleton<Dio>(() => DioClient.dio);

  /// ✅ Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  /// ✅ Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  /// ✅ UseCase
  sl.registerLazySingleton(
    () => SendOtpUseCase(sl()),
  );

  /// ✅ Bloc
sl.registerFactory(
  () => AuthBloc(
    sendOtpUseCase: sl(),
    appPreferences: sl(),   // ✅ REQUIRED
  ),
);

    sl.registerFactory(
    () => OtpTimerCubit(),
  );


   // ======================================================
  // 🟢 NAME SECTION (NEW USER CREATE ACCOUNT)
  // ======================================================

  /// Name Data Source
  sl.registerLazySingleton<NameRemoteDataSource>(
    () => NameRemoteDataSourceImpl(sl()),
  );

  /// Name Repository
  sl.registerLazySingleton<NameRepository>(
    () => NameRepositoryImpl(sl()),
  );

  /// Name UseCase
  sl.registerLazySingleton(
    () => NameUsecase(sl()),
  );

  /// Name Bloc
  sl.registerFactory(
    () => NameBloc(
      createAccountUseCase: sl(),
      appPreferences: sl()
    ),
  );

  /// Data Source
  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(sl()),
  );

  /// Repository
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

  /// Bloc
  sl.registerFactory(
    () => TransactionBloc(
      getTransactionsUseCase: sl(),
      syncTransactionsUseCase: sl(),
      deleteTransactionsUseCase: sl(),
    ),
  );
// ======================================================
// 🟣 CATEGORY SECTION (CATEGORY LISTING)
// ======================================================

/// 🔹 Database
final database = await AppDatabase.database;
sl.registerLazySingleton<Database>(() => database);

/// 🔹 Local Data Source
sl.registerLazySingleton<CategoryLocalDataSource>(
  () => CategoryLocalDataSourceImpl(sl()),
);

/// 🔹 Remote Data Source
sl.registerLazySingleton<CategoryRemoteDataSource>(
  () => CategoryRemoteDataSourceImpl(sl()),
);

/// 🔹 Repository  ✅ FIXED HERE
sl.registerLazySingleton<CategoryRepository>(
  () => CategoryRepositoryImpl(
    local: sl(),
    remote: sl(),
  ),
);

/// 🔹 UseCases
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

/// 🔹 Bloc
sl.registerFactory(
  () => CategoryBloc(
    getCategoriesUseCase: sl(),
    addCategoryUseCase: sl(),
    deleteCategoryUseCase: sl(),
    syncCategoryUseCase: sl(),
  ),
);
}