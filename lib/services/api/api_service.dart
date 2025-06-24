import 'package:dio/dio.dart';

import '../../app/app.logger.dart';
import '../../datamodels/user_model.dart';

class ApiService {
  final log = getLogger('ApiService');
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://reqres.in/api/',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': 'reqres-free-v1'
    },
  ));

  Future<User?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'login',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'reqres-free-v1'
          },
        ),
      );
      log.i('Login request: email=$email, password=$password');
      log.i('Login response: ${response.data}');
      return User.fromJson(response.data);
    } catch (e) {
      log.e('Login error: $e');
      rethrow;
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      final response = await _dio.post(
        'register',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'reqres-free-v1'
          },
        ),
      );
      log.i('Register request: email=$email, password=$password');
      log.i('Register response: ${response.data}');
      return User.fromJson(response.data);
    } catch (e) {
      log.e('Register error: $e');
      rethrow;
    }
  }
}
