import 'dart:convert';
import 'package:application/screens/login/data/auth_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthModel> sendOtp(String phone);
  Future<String> createAccount(String phone, String nickname);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  final String baseUrl = "https://appskilltest.zybotech.in";

  @override
  Future<AuthModel> sendOtp(String phone) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/send-otp'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to send OTP");
    }
  }

  @override
  Future<String> createAccount(String phone, String nickname) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/create-account/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "nickname": nickname,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception("Failed to create account");
    }
  }
}