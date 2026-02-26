import 'package:flutter_bloc/flutter_bloc.dart';
import 'name_event.dart';
import 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc() : super(const NameState()) {
    on<NameChanged>(_onNameChanged);
    on<NameSubmitted>(_onNameSubmitted);
  }

  void _onNameChanged(NameChanged event, Emitter<NameState> emit) {
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

  void _onNameSubmitted(NameSubmitted event, Emitter<NameState> emit) {
    final name = state.name.trim();

    if (name.isEmpty) {
      emit(
        state.copyWith(
          status: NameStatus.invalid,
          errorMessage: "Name cannot be empty",
        ),
      );
    } else if (name.length <= 3) {
      emit(
        state.copyWith(
          status: NameStatus.invalid,
          errorMessage: "Name must be more than 3 characters",
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: NameStatus.success,
          errorMessage: null,
        ),
      );
    }
  }
}