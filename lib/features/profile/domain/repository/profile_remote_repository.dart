import 'package:carinfo/core/network/api_service.dart';
import 'package:carinfo/features/profile/domain/entity/profile_entity.dart';
import 'package:carinfo/features/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRemoteRepository implements ProfileRepository {
  final ApiService apiService;

  ProfileRemoteRepository({required this.apiService});

  @override
  Future<UserEntity> getUserProfile() async {
    try {
      final Response<dynamic>? response =
          await apiService.getRequest('/user/profile');

      if (response != null && response.data != null) {
        final data = response.data as Map<String, dynamic>;

        return UserEntity(
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          role: data['role'] ?? '',
          photoUrl: data['photoUrl'] ?? '',
        );
      } else {
        throw Exception("No data received from the server.");
      }
    } catch (e) {
      throw Exception("Failed to load user profile: ${e.toString()}");
    }
  }
}
