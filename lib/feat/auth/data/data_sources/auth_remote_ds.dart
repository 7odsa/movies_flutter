import 'dart:convert';

import 'package:movies_flutter/_resources/data_state.dart';
import 'package:movies_flutter/feat/auth/data/models/user.dart';

import 'package:http/http.dart' as http;

class AuthRemoteDS {
  final String _authBaseUrl = 'route-movie-apis.vercel.app';

  Future<DataState<UserDm>> register(UserDm user) async {
    try {
      final body = jsonEncode(user.toJson());
      final url = Uri.https(_authBaseUrl, 'auth/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DataFailed('Something Went Wrong');
      }
      final json = jsonDecode(response.body);
      return DataSuccess(
        user.copyWith(id: (json['data'] as Map<String, dynamic>)['_id']),
      );
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> login(String email, String password) async {
    try {
      final body = jsonEncode({'email': email, 'password': password});
      final url = Uri.https(_authBaseUrl, 'auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DataFailed('Something Went Wrong');
      }
      final json = jsonDecode(response.body);
      print(json['data']);
      return DataSuccess((json['data']));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> resetPassword(
    String token,
    String oldPassword,
    String newPassword,
  ) async {
    // !  NOT TESTED YET
    try {
      final body = jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
      final url = Uri.https(_authBaseUrl, 'auth/rest-password');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DataFailed('Something Went Wrong');
      }
      final json = jsonDecode(response.body);
      print(json['data']);
      return DataSuccess((json['data']));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> updateProfile({
    required String token,
    required String phone,
    required String name,
    required String email,
    required int avatarId,
  }) async {
    // !  NOT TESTED YET
    try {
      final body = jsonEncode({
        'email': email,
        'name': name,
        'phone': phone,
        'avaterId': avatarId,
      });
      final url = Uri.https(_authBaseUrl, 'profile');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DataFailed('Something Went Wrong');
      }
      final json = jsonDecode(response.body);
      print(json['data']);
      return DataSuccess((json['data']));
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<UserDm>> getProfile({required String token}) async {
    // !  NOT TESTED YET
    try {
      final url = Uri.https(_authBaseUrl, 'profile');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DataFailed('Something Went Wrong');
      }
      final json = jsonDecode(response.body);
      return DataSuccess(
        UserDm.fromJson((json['data'] as Map<String, dynamic>)),
      );
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  // TODO:  Delete Profile

  // TODO:  add movie to favorite
  // TODO:  get all favorites movies
  // TODO:  remove movie
  // TODO:  movie is favorite

  // Future<DataState<UserDm>> getProfile(UserDm user) async {
  //   try {
  //     final url = Uri.https(_authBaseUrl, 'profile');

  //     final response = await http.get(url,headers: ['Authorization':'Bearer']);

  //     if (response.statusCode < 200 && response.statusCode <= 300) {
  //       return DataFailed('Something Went Wrong');
  //     }

  //     return DataSuccess(user);
  //   } catch (e) {
  //     return DataFailed(e.toString());
  //   }
  // }
}
