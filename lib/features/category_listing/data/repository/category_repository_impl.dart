import 'package:application/features/category_listing/data/datasource/category_local_data_source.dart';
import 'package:application/features/category_listing/data/datasource/category_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/category_entity.dart';
import '../../domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {

  final CategoryLocalDataSource local;
  final CategoryRemoteDataSource remote;

  CategoryRepositoryImpl({
    required this.local,
    required this.remote,
  });

  // =============================
  // GET
  // =============================
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final result = await local.getCategories();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  // =============================
  // ADD (Local Insert)
  // =============================
  @override
  Future<Either<Failure, Unit>> addCategory(
      CategoryEntity category) async {
    try {
      await local.insertCategory(category);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  // =============================
  // SOFT DELETE
  // =============================
  @override
  Future<Either<Failure, Unit>> softDeleteCategory(
      String id) async {
    try {
      await local.markDeleted(id);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  // =============================
  // SYNC WORKFLOW
  // =============================
  @override
  Future<Either<Failure, Unit>> syncCategories() async {
    try {

      // 🔥 STEP A — CLOUD PURGE
      final deleted = await local.getDeletedCategories();

      if (deleted.isNotEmpty) {
        final ids = deleted.map((e) => e.id).toList();

        await remote.deleteCategories(ids);
        await local.permanentlyDelete(ids);
      }

      // 🔥 STEP B — UPLOAD NEW
      final unsynced = await local.getUnsyncedCategories();

      if (unsynced.isNotEmpty) {
        await remote.syncCategories(unsynced);

        await local.markSynced(
          unsynced.map((e) => e.id).toList(),
        );
      }

      return const Right(unit);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}