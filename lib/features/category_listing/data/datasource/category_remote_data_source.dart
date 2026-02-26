import 'package:application/features/category_listing/domain/entity/category_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../model/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}