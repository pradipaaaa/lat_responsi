import 'package:shared_preferences/shared_preferences.dart';

enum LoginFailure { accountMissing, invalidCredentials }

class LoginResult {
  const LoginResult._({this.failure});

  const LoginResult.success() : this._();

  const LoginResult.failed(LoginFailure failure) : this._(failure: failure);

  final LoginFailure? failure;

  bool get isSuccess => failure == null;
}

class AuthRepository {
  AuthRepository._();

  static const _usernameKey = 'registered_username';
  static const _passwordKey = 'registered_password';
  static const _loggedInKey = 'is_logged_in';

  static Future<String?> currentUsernameIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final isLoggedIn = prefs.getBool(_loggedInKey) ?? false;

    if (!isLoggedIn || username == null) return null;
    return username;
  }

  static Future<LoginResult> login({
    required String username,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString(_usernameKey);
    final savedPassword = prefs.getString(_passwordKey);

    if (savedUsername == null || savedPassword == null) {
      return const LoginResult.failed(LoginFailure.accountMissing);
    }

    if (username != savedUsername || password != savedPassword) {
      return const LoginResult.failed(LoginFailure.invalidCredentials);
    }

    await prefs.setBool(_loggedInKey, true);
    return const LoginResult.success();
  }

  static Future<void> register({
    required String username,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_loggedInKey, false);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
  }
}
