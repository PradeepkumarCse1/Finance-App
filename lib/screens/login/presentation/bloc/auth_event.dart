abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String phone;
  SendOtpEvent(this.phone);
}

class VerifyOtpEvent extends AuthEvent {
  final String enteredOtp;
  VerifyOtpEvent(this.enteredOtp);
}

class CreateAccountEvent extends AuthEvent {
  final String phone;
  final String nickname;

  CreateAccountEvent(this.phone, this.nickname);
}

class ResendOtpEvent extends AuthEvent {
  final String phone;

   ResendOtpEvent(this.phone);
}