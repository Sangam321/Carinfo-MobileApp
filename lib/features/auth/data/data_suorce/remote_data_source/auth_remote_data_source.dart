import 'dart:io';

import 'package:carinfo/app/constants/api_endpoints.dart';
import 'package:carinfo/features/auth/data/data_suorce/auth_data_source.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "name": user.name,
          "email": user.email,
          "image": user.image,
          "password": user.password,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // First, check for token in response headers (cookies)
        String? token;

        // Extract token from cookies (Set-Cookie header)
        if (response.headers.map.containsKey('set-cookie')) {
          String cookieHeader = response.headers.map['set-cookie']!.first;
          RegExp regExp = RegExp(r'token=([^;]+)');
          Match? match = regExp.firstMatch(cookieHeader);
          if (match != null) {
            token = match.group(1);
          }
        }

        // If token was not found in cookies, check the response body
        token ??= response.data['token'];

        if (token == null) {
          throw Exception('Token not found in response');
        }

        return token;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
