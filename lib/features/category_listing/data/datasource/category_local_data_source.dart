import '../../domain/entity/category_entity.dart';

abstract class CategoryLocalDataSource {

  Future<List<CategoryEntity>> getCategories();

  Future<void> insertCategory(CategoryEntity category);

  Future<void> markDeleted(String id);

  Future<void> permanentlyDelete(List<String> ids);

  Future<List<CategoryEntity>> getDeletedCategories();

  Future<List<CategoryEntity>> getUnsyncedCategories();

  Future<void> markSynced(List<String> ids);
}