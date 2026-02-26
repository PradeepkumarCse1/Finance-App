import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entity/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}