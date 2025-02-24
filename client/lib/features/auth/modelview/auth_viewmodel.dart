import 'package:client/features/auth/repositories/auth_remote_repositories.dart';
import 'package:client/features/auth/repositories/auth_local_repositories.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepositories _remoteRepositories;
  late AuthLocalRepositories _localRepositories;

  @override
  AsyncValue<Map<String, dynamic>>? build() {
    _remoteRepositories = ref.watch(authRemoteRepositoriesProvider);
    _localRepositories = ref.watch(authLocalRepositoriesProvider);
    return null;
  }

  // ✅ Login
  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response =
          await _remoteRepositories.logIn(email: email, password: password);

      if (response['success'] == true) {
        final token = response['token'];
        if (token != null) {
          await _localRepositories.saveToken(token);
        }
      }

      state = AsyncValue.data(response);
      return response;
    } catch (error, stackTrace) {
      state = AsyncValue.error(
          "Login failed. Please check credentials@@@@@@@@.", stackTrace);
      throw Exception("Login failed. Please check credentials.");
    }
  }

  Future<void> logout(BuildContext context) async {
    state = AsyncValue.loading();

    try {
      final token = await _localRepositories.getToken();
      if (token != null) {
        final response = await _remoteRepositories.logout(token);
        print("Logout API Response: $response");
      }

      await _localRepositories.removeToken(); // Clear local token

      // ✅ Redirect user to LoginPage after logout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );

      state = AsyncValue.data({"success": true});
    } catch (error, stackTrace) {
      state =
          AsyncValue.error("Couldn't logout. Please try again.", stackTrace);
      throw Exception("Couldn't logout. Please try again.");
    }
  }

  // ✅ Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _localRepositories.getToken();
    return token != null && token.isNotEmpty; // Ensure valid token
  }

  // ✅ Signup
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = AsyncValue.loading();
    try {
      final response = await _remoteRepositories.signUp(
          email: email, password: password, name: name);
      state = AsyncValue.data(response);
      return response;
    } catch (error, stackTrace) {
      state = AsyncValue.error(
          "Signup failed. User may already exist.", stackTrace);
      throw Exception("Signup failed. User may already exist.");
    }
  }
}
