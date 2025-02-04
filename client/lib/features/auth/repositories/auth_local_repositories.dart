import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_local_repositories.g.dart';

@riverpod
AuthLocalRepositories authLocalRepositories(Ref ref) {
  return AuthLocalRepositories();
}

class AuthLocalRepositories {
  static const String _tokenKey = 'auth_token';
  SharedPreferences? _prefs; // Nullable to avoid late initialization error

  // Ensure SharedPreferences is initialized
  Future<void> _ensureInitialized() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Store Token
  Future<void> saveToken(String token) async {
    await _ensureInitialized();
    print('hey man');
    if (_prefs != null) {
      await _prefs!.setString(_tokenKey, token);
      print('Token saved: $token');
    } else {
      print('SharedPreferences not initialized');
    }
  }

  // Get Token
  Future<String?> getToken() async {
    await _ensureInitialized();
    return _prefs?.getString(_tokenKey); // Avoid direct access to _prefs!
  }

  // Remove Token (Logout)
  Future<void> removeToken() async {
    await _ensureInitialized();
    _prefs?.remove(_tokenKey); // Null-safe check
  }

  // Check if User is Logged In
  Future<bool> isLoggedIn() async {
    return (await getToken()) != null;
  }
}
