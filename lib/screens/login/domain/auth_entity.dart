class AuthEntity {
  final String otp;
  final bool userExists;
  final String? nickname;
  final String token;

  AuthEntity({
    required this.otp,
    required this.userExists,
    required this.token,
    this.nickname,
  });
}