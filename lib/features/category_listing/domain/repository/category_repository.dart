import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entity/category_entity.dart';

abstract class CategoryRepository {

  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  Future<Either<Failure, Unit>> addCategory(CategoryEntity category);

  Future<Either<Failure, Unit>> softDeleteCategory(String id);

  Future<Either<Failure, Unit>> syncCategories();
}