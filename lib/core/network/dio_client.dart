import 'package:application/core/app_preferences.dart';
import 'package:application/core/service_locator.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://appskilltest.zybotech.in",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )
    ..interceptors.add(
      InterceptorsWrapper(

        onRequest: (options, handler) {

          final token = sl<AppPreferences>().getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          print("REQUEST HEADER → ${options.headers}");

          return handler.next(options);
        },
      ),
    );
}