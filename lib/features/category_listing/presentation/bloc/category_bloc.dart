import 'package:application/features/category_listing/domain/usecase/category_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc
    extends Bloc<CategoryEvent, CategoryState> {

  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc({
    required this.getCategoriesUseCase,
  }) : super(const CategoryState()) {

    on<LoadCategoriesEvent>((event, emit) async {

      emit(state.copyWith(status: CategoryStatus.loading));

      final result = await getCategoriesUseCase();

      result.fold(

        /// ❌ FAILURE
        (failure) {
          emit(
            state.copyWith(
              status: CategoryStatus.error,
              errorMessage: failure.message,
            ),
          );
        },

        /// ✅ SUCCESS
        (categories) {
          emit(
            state.copyWith(
              status: CategoryStatus.loaded,
              categories: categories,
            ),
          );
        },
      );
    });
  }
}