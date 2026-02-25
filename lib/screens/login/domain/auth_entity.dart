class AuthEntity {
  final String status;
  final String otp;
  final bool userExists;
  final String? nickname;
  final String token;

  AuthEntity({
    required this.status,
    required this.otp,
    required this.userExists,
    required this.nickname,
    required this.token,
  });
}