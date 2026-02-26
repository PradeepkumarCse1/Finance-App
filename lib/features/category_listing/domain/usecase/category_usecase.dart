import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entity/category_entity.dart';
import '../repository/category_repository.dart';

class GetCategoriesUseCase {

  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}