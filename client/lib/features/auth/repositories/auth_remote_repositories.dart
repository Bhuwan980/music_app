import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'auth_remote_repositories.g.dart';

@riverpod
AuthRemoteRepositories authRemoteRepositories(Ref ref) {
  return AuthRemoteRepositories();
}

class AuthRemoteRepositories {
  final domainAddress = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = Uri.parse('$domainAddress/users/signup');

    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
            {
              'email': email,
              'password': password,
              'name': name,
            },
          ));
      // print(response.body);
      //print(response.statusCode);
      if (response.statusCode == 201) {
        return {'success': true};
      } else {
        return {
          'success': false,
          'errorMessage': jsonDecode(response.body)['detail']
        };
      }
    } catch (e) {
      return {'success': false, 'errorMessage': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$domainAddress/users/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      final responseBody = jsonDecode(response.body);
      //print(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'token': responseBody['token'],
          'user': responseBody['user']
        };
      } else {
        return {
          'success': false,
          'errorMessage': jsonDecode(response.body)['detail']
        };
      }
    } catch (e) {
      return {'success': false, 'errorMessage': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> logout(String token) async {
    final url = Uri.parse('$domainAddress/users/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"token": token}), // ✅ Fixed JSON encoding
      );

      if (response.statusCode == 200) {
        return {'success': true, "message": jsonDecode(response.body)};
      } else {
        return {
          'success': false,
          'errorMessage': "Logout failed: ${response.body}"
        };
      }
    } catch (e) {
      return {'success': false, 'errorMessage': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    final url = Uri.parse('$domainAddress/users/me');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return {'success': true, "user": jsonDecode(response.body)};
      } else {
        return {'success': false, 'errorMessage': "Failed to get user data"};
      }
    } catch (e) {
      return {'success': false, 'errorMessage': 'An error occurred: $e'};
    }
  }
}
