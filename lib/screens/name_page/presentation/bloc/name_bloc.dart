import 'package:application/core/app_preferences.dart';
import 'package:application/screens/name_page/domain/usecase/name_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'name_event.dart';
import 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  final NameUsecase createAccountUseCase;
  final AppPreferences appPreferences;

  NameBloc({
    required this.createAccountUseCase,
    required this.appPreferences,
  }) : super(const NameState()) {
    on<NameChanged>(_onNameChanged);
    on<NameSubmitted>(_onNameSubmitted);
  }

  /// 🔤 Handle Name Typing
  void _onNameChanged(
    NameChanged event,
    Emitter<NameState> emit,
  ) {
    final name = event.name.trim();

    if (name.length > 3) {
      emit(
        state.copyWith(
          name: event.name,
          status: NameStatus.valid,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          name: event.name,
          status: NameStatus.typing,
          errorMessage: null,
        ),
      );
    }
  }

  /// 🚀 Handle Submit
  Future<void> _onNameSubmitted(
    NameSubmitted event,
    Emitter<NameState> emit,
  ) async {
    final name = state.name.trim();

    /// ❌ Local Validation
    if (name.isEmpty) {
      emit(
        state.copyWith(
          status: NameStatus.invalid,
          errorMessage: "Name cannot be empty",
        ),
      );
      return;
    }

    if (name.length <= 3) {
      emit(
        state.copyWith(
          status: NameStatus.invalid,
          errorMessage: "Name must be more than 3 characters",
        ),
      );
      return;
    }

    /// 🔄 Show Loading
    emit(state.copyWith(status: NameStatus.submitting));

    try {
      /// 📱 Get stored phone
      final phone = appPreferences.getPhone() ?? '';

      /// 📡 API Call
      final result = await createAccountUseCase(name, phone);

   result.fold(
  (failure) {
    emit(
      state.copyWith(
        status: NameStatus.error,
        errorMessage: failure.message,
      ),
    );
  },
  (token) {
    appPreferences.saveToken(token);
    emit(
      state.copyWith(
        status: NameStatus.success,
        errorMessage: null,
      ),
    );
  },
);
    } catch (e) {
      emit(
        state.copyWith(
          status: NameStatus.error,
          errorMessage: "Something went wrong. Please try again.",
        ),
      );
    }
  }
}