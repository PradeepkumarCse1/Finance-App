import 'package:application/core/failure/failure.dart';
import 'package:application/features/category_listing/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../model/category_model.dart';
import 'category_remote_data_source.dart';
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {

  final Dio dio;

  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {

    try {

      final response = await dio.get('/categories/');

      final List list = response.data['categories'];

      final categories = list
          .map((e) => CategoryModel.fromJson(e).toEntity())
          .toList();

      return Right(categories);

    } on DioException catch (e) {

      return Left(ServerFailure(e.message ?? "Server error"));
    }
  }
}