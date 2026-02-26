import 'package:application/features/category_listing/domain/repository/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> call(String id) {
    return repository.softDeleteCategory(id);
  }
}