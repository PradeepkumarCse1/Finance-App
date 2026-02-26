import 'package:application/screens/login/presentation/cubit/otp_timer_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:application/core/network/dio_client.dart';

import 'package:application/screens/login/data/auth_remote_datasource.dart';
import 'package:application/screens/login/data/auth_remote_datasource_impl.dart';
import 'package:application/screens/login/data/auth_repository_impl.dart';
import 'package:application/screens/login/domain/auth_repository.dart';
import 'package:application/screens/login/domain/auth_usecase.dart';
import 'package:application/screens/login/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

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
    () => AuthBloc(sendOtpUseCase: sl()),
  );

    sl.registerFactory(
    () => OtpTimerCubit(),
  );
}