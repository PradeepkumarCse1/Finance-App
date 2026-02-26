import 'package:application/core/failure/failure.dart';
import 'package:application/features/category_listing/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../model/category_model.dart';
import 'category_remote_data_source.dart';

class CategoryRemoteDataSourceImpl
    implements CategoryRemoteDataSource {

  final Dio dio;

  CategoryRemoteDataSourceImpl(this.dio);

  // ====================================================
  // GET CATEGORIES
  // ====================================================
  @override
  Future<Either<Failure, List<CategoryEntity>>>
      getCategories() async {

    try {
      final response = await dio.get('/categories/');

      final List list = response.data['categories'];

      final categories = list
          .map((e) => CategoryModel.fromJson(e).toEntity())
          .toList();

      return Right(categories);

    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ====================================================
  // BATCH SYNC (POST)
  // ====================================================
  @override
  Future<Either<Failure, Unit>> syncCategories(
      List<CategoryEntity> categories) async {

    try {
      await dio.post(
        '/categories/add/',
        data: {
          "categories": categories.map((e) => {
            "id": e.id,
            "name": e.name,
          }).toList(),
        },
      );

      return const Right(unit);

    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ====================================================
  // BATCH DELETE
  // ====================================================
  @override
  Future<Either<Failure, Unit>> deleteCategories(
      List<String> ids) async {

    try {
      await dio.delete(
        '/categories/delete/',
        data: {
          "ids": ids,
        },
      );

      return const Right(unit);

    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ====================================================
  // DIO ERROR MAPPER
  // ====================================================
  Failure _handleDioError(DioException e) {

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ServerFailure("Connection timeout");
    }

    if (e.type == DioExceptionType.badResponse) {
      return ServerFailure(
        e.response?.data?["message"] ?? "Server error",
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return ServerFailure("No internet connection");
    }

    return ServerFailure(e.message ?? "Unexpected error");
  }
}