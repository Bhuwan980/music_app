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
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = Uri.parse('http://localhost:8000/users/signup');

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
      print(response.body);
      print(response.statusCode);
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
    final url = Uri.parse('http://localhost:8000/users/login');

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
      print(response.body);
      if (response.statusCode == 200) {
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
}
