import 'package:application/screens/login/domain/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtpUseCase;
  // final CreateAccountUseCase createAccountUseCase;

  String? _serverOtp;
  bool? _userExists;
  String? _phone;

  AuthBloc({
    required this.sendOtpUseCase,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final result = await sendOtpUseCase(event.phone);
        print(result.otp);

        _serverOtp = result.otp;
        _userExists = result.userExists;
        _phone = event.phone;

        emit(OtpSentState(result));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      if (event.enteredOtp == _serverOtp) {
        if (_userExists == true) {
          emit(AuthenticatedState("Login Success"));
        } else {
          emit(NewUserState(_phone!));
        }
      } else {
        emit(AuthError("Invalid OTP"));
      }
    });

    // on<CreateAccountEvent>((event, emit) async {
    //   emit(AuthLoading());

    //   try {
    //     final token =
    //         await createAccountUseCase(event.phone, event.nickname);
    //     emit(AuthenticatedState(token));
    //   } catch (e) {
    //     emit(AuthError(e.toString()));
    //   }
    // });
  }
}