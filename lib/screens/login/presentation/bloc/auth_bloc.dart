import 'package:application/core/app_preferences.dart';
import 'package:application/screens/login/domain/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SendOtpUseCase sendOtpUseCase;
  final AppPreferences appPreferences;

  String? _serverOtp;
  String? _phone;

  String? get phone => _phone;

  AuthBloc({
    required this.sendOtpUseCase,
    required this.appPreferences,
  }) : super(const AuthState()) {

    /// ✅ SEND OTP
    on<SendOtpEvent>((event, emit) async {

      emit(state.copyWith(status: AuthStatus.loading));

      _phone = event.phone;

      final result = await sendOtpUseCase(event.phone);

      result.fold(

        /// ❌ FAILURE
        (failure) {
          emit(
            state.copyWith(
              status: AuthStatus.error,
              errorMessage: failure.message,
            ),
          );
        },

        /// ✅ SUCCESS
        (authData) {

          _serverOtp = authData.otp;

          emit(
            state.copyWith(
              status: AuthStatus.otpSent,
              authData: authData,
            ),
          );
        },
      );
    });

    /// ✅ VERIFY OTP (ONLY ONE HANDLER 😎🔥)
    on<VerifyOtpEvent>((event, emit) async {

      /// ❌ INVALID OTP
      if (event.enteredOtp != _serverOtp) {

        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: "Invalid OTP",
          ),
        );

        return;
      }

      final authData = state.authData!;

      /// ✅ EXISTING USER
      if (authData.userExists) {

        /// 🔥 STORE SESSION (YOUR PREFERENCES CLASS)
        await appPreferences.saveSession(
          token: authData.token,
          nickname: authData.nickname??"",
          phone: _phone??"",
        );

        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            token: authData.token,
            nickname: authData.nickname,
          ),
        );
      }

      /// ✅ NEW USER
      else {
        emit(
          state.copyWith(
            status: AuthStatus.newUser,
          ),
        );
      }
    });

    /// ✅ RESEND OTP
    on<ResendOtpEvent>((event, emit) async {

      emit(state.copyWith(status: AuthStatus.loading));

      final result = await sendOtpUseCase(event.phone);

      result.fold(

        /// ❌ FAILURE
        (failure) {
          emit(
            state.copyWith(
              status: AuthStatus.error,
              errorMessage: failure.message,
            ),
          );
        },

        /// ✅ SUCCESS
        (authData) {

          _serverOtp = authData.otp;

          emit(
            state.copyWith(
              status: AuthStatus.otpResent,
            ),
          );
        },
      );
    });
  }
}