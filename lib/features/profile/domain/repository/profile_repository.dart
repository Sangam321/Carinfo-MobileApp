import 'package:carinfo/features/profile/domain/entity/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile();
}
