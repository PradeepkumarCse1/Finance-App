import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  static const String tokenKey = "TOKEN";
  static const String nicknameKey = "NICKNAME";
  static const String phoneKey = "PHONE";

  final SharedPreferences prefs;

  AppPreferences(this.prefs);

  /// ✅ TOKEN

  Future<void> saveToken(String token) async {
    await prefs.setString(tokenKey, token);
  }

  String? getToken() {
    return prefs.getString(tokenKey);
  }

  /// ✅ NICKNAME

  Future<void> saveNickname(String nickname) async {
    await prefs.setString(nicknameKey, nickname);
  }

  String? getNickname() {
    return prefs.getString(nicknameKey);
  }

  /// ✅ PHONE

  Future<void> savePhone(String phone) async {
    await prefs.setString(phoneKey, phone);
  }

  String? getPhone() {
    return prefs.getString(phoneKey);
  }

  /// ✅ Save Entire Session (VERY CLEAN)

  Future<void> saveSession({
    required String token,
    required String nickname,
    required String phone,
  }) async {
    await prefs.setString(tokenKey, token);
    await prefs.setString(nicknameKey, nickname);
    await prefs.setString(phoneKey, phone);
  }

  /// ✅ Clear Session (Logout)

  Future<void> clearSession() async {
    await prefs.remove(tokenKey);
    await prefs.remove(nicknameKey);
    await prefs.remove(phoneKey);
  }
}