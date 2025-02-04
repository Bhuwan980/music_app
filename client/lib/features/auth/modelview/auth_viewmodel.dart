import 'package:client/features/auth/repositories/auth_remote_repositories.dart';
import 'package:client/features/auth/repositories/auth_local_repositories.dart'; // Import local auth repo
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

// login
  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    print('logiin))in');
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
      print('$response -------');
      return response;
    } catch (error, stackTrace) {
      state = AsyncValue.error('Invalid credentials', stackTrace);
      throw Exception('Invalid credentials');
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      state = AsyncValue.loading();
      final response = await _remoteRepositories.logout(); // Add `await` here
      if (response['success'] == true) {
        await _localRepositories.removeToken(); // Clear the token locally
        state = AsyncValue.data(response);
        return response;
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      throw Exception("Couldn't logout. Please try again later.");
    }
    return {};
  }

  Future<bool> isLoggedIn() async {
    final token = await _localRepositories
        .getToken(); // Retrieve token from local storage
    return token != null; // If token exists, return true
  }

//signup
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
      state = AsyncValue.error('User already exists!', stackTrace);
      throw Exception('User already exists!');
    }
  }
}
