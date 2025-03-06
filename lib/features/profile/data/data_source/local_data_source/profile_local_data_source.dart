// profile_local_data_source.dart
import 'package:carinfo/features/profile/data/model/profile_model.dart';
import 'package:hive/hive.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel?> getProfile();
  Future<void> saveProfile(ProfileModel profile);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<ProfileModel?> getProfile() async {
    var box = await Hive.openBox<ProfileModel>('profileBox');
    return box.get('profile');
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    var box = await Hive.openBox<ProfileModel>('profileBox');
    await box.put('profile', profile);
  }
}
