import 'package:application/features/category_listing/domain/repository/category_repository.dart';

class SyncCategoryUseCase {
  final CategoryRepository repository;

  SyncCategoryUseCase(this.repository);

  Future<void> call() {
    return repository.syncCategories();
  }
}