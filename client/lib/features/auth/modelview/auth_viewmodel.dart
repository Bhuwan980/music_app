import 'package:client/features/auth/repositories/auth_remote_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepositories _repositories;

  @override
  AsyncValue<Map<String, dynamic>>? build() {
    _repositories = ref.watch(authRemoteRepositoriesProvider);
    return null;
  }

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    await Future.delayed(const Duration(seconds: 3));
    print(password);

    try {
      final response =
          await _repositories.logIn(email: email, password: password);
      state = AsyncValue.data(response);
      return response;
    } catch (error, stackTrace) {
      state = AsyncValue.error('Invalid credentials', stackTrace);
      throw Exception('Invalid credentials');
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await _repositories.signUp(
          email: email, password: password, name: name);
      state = AsyncValue.data(response);
      return response;
    } catch (error, stackTrace) {
      state = AsyncValue.error('User already exists!', stackTrace);
      throw Exception('User already exists!');
    }
  }
}
