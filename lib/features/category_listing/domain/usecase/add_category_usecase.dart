import 'package:application/features/category_listing/domain/entity/category_entity.dart';
import 'package:application/features/category_listing/domain/repository/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) {
    return repository.addCategory(category);
  }
}