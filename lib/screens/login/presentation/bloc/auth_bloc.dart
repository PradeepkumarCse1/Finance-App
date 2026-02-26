import 'package:application/screens/login/domain/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SendOtpUseCase sendOtpUseCase;

  String? _serverOtp;

  AuthBloc({required this.sendOtpUseCase})
      : super(const AuthState()) {

    /// ✅ SEND OTP
    on<SendOtpEvent>((event, emit) async {

      emit(state.copyWith(status: AuthStatus.loading));

      final result = await sendOtpUseCase(event.phone);

      result.fold(

        /// FAILURE
        (failure) {
          emit(state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ));
        },

        /// SUCCESS
        (authData) {

          _serverOtp = authData.otp;

          emit(state.copyWith(
            status: AuthStatus.otpSent,
            authData: authData,
          ));
        },
      );
    });

    /// ✅ VERIFY OTP
    on<VerifyOtpEvent>((event, emit) {

      if (event.enteredOtp != _serverOtp) {

        emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: "Invalid OTP",
        ));

        return;
      }

      /// OTP Correct
      final authData = state.authData!;

      if (authData.userExists) {

        emit(state.copyWith(
          status: AuthStatus.authenticated,
        ));

      } else {

        emit(state.copyWith(
          status: AuthStatus.verified,
        ));
      }
    });
  }
}