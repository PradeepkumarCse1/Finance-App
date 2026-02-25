import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:application/screens/login/data/auth_datasource.dart';
import 'package:application/screens/login/data/auth_repository_impl.dart';
import 'package:application/screens/login/domain/auth_repository.dart';
import 'package:application/screens/login/domain/auth_usecase.dart';
import 'package:application/screens/login/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  /// ✅ External
  sl.registerLazySingleton(() => http.Client());

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
}