import 'package:application/features/category_listing/data/datasource/category_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/category_entity.dart';
import '../../domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {

  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    return await remoteDataSource.getCategories();
  }
}