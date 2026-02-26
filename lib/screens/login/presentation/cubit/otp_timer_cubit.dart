import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpTimerCubit extends Cubit<int> {

  Timer? _timer;

  OtpTimerCubit() : super(30);   // ✅ Start from 30 seconds

  void startTimer() {

    emit(30);

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (state == 0) {
        timer.cancel();
      } else {
        emit(state - 1);
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}