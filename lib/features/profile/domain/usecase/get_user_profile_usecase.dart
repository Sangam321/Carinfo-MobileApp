import 'package:carinfo/features/profile/domain/entity/user_entity.dart';
import 'package:carinfo/features/profile/domain/repository/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository profileRepository;

  GetUserProfileUseCase({required this.profileRepository});

  Future<UserEntity> call() async {
    return await profileRepository.getUserProfile();
  }
}
