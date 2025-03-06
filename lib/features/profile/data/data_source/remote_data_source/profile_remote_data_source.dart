// profile_remote_data_source.dart
import 'package:carinfo/app/constants/api_endpoints.dart';
import 'package:carinfo/features/profile/data/model/profile_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await dio.get(ApiEndpoints.getUserProfile);
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    await dio.put(
      ApiEndpoints.updateProfile,
      data: profile.toJson(),
    );
  }
}
