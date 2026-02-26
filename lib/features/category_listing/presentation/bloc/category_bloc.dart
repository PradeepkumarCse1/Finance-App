import 'package:application/features/category_listing/domain/entity/category_entity.dart';
import 'package:application/features/category_listing/domain/usecase/add_category_usecase.dart';
import 'package:application/features/category_listing/domain/usecase/category_usecase.dart';
import 'package:application/features/category_listing/domain/usecase/delete_category_usecase.dart';
import 'package:application/features/category_listing/domain/usecase/sync_category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final SyncCategoryUseCase syncCategoryUseCase; // 👈 add this

  CategoryBloc({
    required this.getCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.deleteCategoryUseCase,
        required this.syncCategoryUseCase, // 👈 add this

  }) : super(const CategoryState()) {
on<SyncCategoriesEvent>((event, emit) async {
  await syncCategoryUseCase();
  add(LoadCategoriesEvent()); // refresh after sync
});
    /// 🔹 LOAD
    on<LoadCategoriesEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));

      final result = await getCategoriesUseCase();

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: CategoryStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (categories) => emit(
          state.copyWith(
            status: CategoryStatus.loaded,
            categories: categories,
          ),
        ),
      );
    });

    /// 🔹 ADD
 /// 🔹 ADD
on<AddCategoryEvent>((event, emit) async {

  final category = CategoryEntity(
    id: DateTime.now().millisecondsSinceEpoch.toString(), 
    name: event.name,
  );

  await addCategoryUseCase(category);

  add(LoadCategoriesEvent()); // refresh list
});
    /// 🔹 DELETE
    on<DeleteCategoryEvent>((event, emit) async {
      await deleteCategoryUseCase(event.id);
      add(LoadCategoriesEvent()); // refresh list
    });
  }
  
}