import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyUsername = 'username';
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyRegisteredUsers = 'registeredUsers';

  /// Register a new user. Returns false if username already exists.
  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_keyRegisteredUsers) ?? [];

    if (users.contains(username)) {
      return false; // Username sudah terdaftar
    }

    users.add(username);
    await prefs.setStringList(_keyRegisteredUsers, users);
    await prefs.setString('pwd_$username', password);
    return true;
  }

  /// Login with username and password. Saves session on success.
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_keyRegisteredUsers) ?? [];

    if (!users.contains(username)) return false;

    final storedPassword = prefs.getString('pwd_$username') ?? '';
    if (storedPassword != password) return false;

    // Save session
    await prefs.setString(_keyUsername, username);
    await prefs.setBool(_keyIsLoggedIn, true);
    return true;
  }

  /// Logout - clear session but keep registered users
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  /// Check if user is currently logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Get the currently logged-in username
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? 'User';
  }
}
