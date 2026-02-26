import 'package:application/features/category_listing/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';

abstract class CategoryRemoteDataSource {

  /// GET
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  /// POST (Batch Sync)
  Future<Either<Failure, Unit>> syncCategories(
      List<CategoryEntity> categories);

  /// DELETE (Batch Delete)
  Future<Either<Failure, Unit>> deleteCategories(
      List<String> ids);
}