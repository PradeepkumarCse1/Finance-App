import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {

  static const int totalPages = 3;

  OnboardingBloc() : super(const OnboardingState(currentPage: 0)) {

    /// swipe event
    on<PageChangedEvent>((event, emit) {
      emit(state.copyWith(currentPage: event.index));
    });

    /// next button
    on<NextPageEvent>((event, emit) {
      if (state.currentPage < totalPages - 1) {
        emit(state.copyWith(currentPage: state.currentPage + 1));
      }
    });

    /// back button
    on<PreviousPageEvent>((event, emit) {
      if (state.currentPage > 0) {
        emit(state.copyWith(currentPage: state.currentPage - 1));
      }
    });
  }
}