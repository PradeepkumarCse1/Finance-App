import 'package:sqflite/sqflite.dart';
import '../../domain/entity/category_entity.dart';
import '../model/category_model.dart';
import 'category_local_data_source.dart';

class CategoryLocalDataSourceImpl
    implements CategoryLocalDataSource {

  final Database db;

  CategoryLocalDataSourceImpl(this.db);

  @override
  Future<List<CategoryEntity>> getCategories() async {

    final result = await db.query(
      "categories",
      where: "is_deleted = 0",
    );

    return result
        .map((e) => CategoryModel.fromJson(e).toEntity())
        .toList();
  }

  @override
  Future<void> insertCategory(CategoryEntity category) async {
    await db.insert(
      "categories",
      {
        "id": category.id,
        "name": category.name,
        "is_synced": 0,
        "is_deleted": 0,
      },
    );
  }

  @override
  Future<void> markDeleted(String id) async {
    await db.update(
      "categories",
      {"is_deleted": 1},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<void> permanentlyDelete(List<String> ids) async {
    await db.delete(
      "categories",
      where: "id IN (${ids.map((_) => "?").join(",")})",
      whereArgs: ids,
    );
  }

  @override
  Future<List<CategoryEntity>> getDeletedCategories() async {

    final result = await db.query(
      "categories",
      where: "is_deleted = 1",
    );

    return result
        .map((e) => CategoryModel.fromJson(e).toEntity())
        .toList();
  }

  @override
  Future<List<CategoryEntity>> getUnsyncedCategories() async {

    final result = await db.query(
      "categories",
      where: "is_synced = 0 AND is_deleted = 0",
    );

    return result
        .map((e) => CategoryModel.fromJson(e).toEntity())
        .toList();
  }

  @override
  Future<void> markSynced(List<String> ids) async {
    await db.update(
      "categories",
      {"is_synced": 1},
      where: "id IN (${ids.map((_) => "?").join(",")})",
      whereArgs: ids,
    );
  }
}