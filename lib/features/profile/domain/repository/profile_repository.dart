// profile_repository.dart
import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:carinfo/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:carinfo/features/profile/domain/entity/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile(ProfileEntity profile);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      // First try to fetch from local storage
      final localProfile = await localDataSource.getProfile();
      if (localProfile != null) {
        return Right(localProfile.toEntity());
      } else {
        // If no profile in local storage, fetch from remote
        final remoteProfile = await remoteDataSource.getProfile();
        localDataSource.saveProfile(remoteProfile);
        return Right(remoteProfile.toEntity());
      }
    } catch (e) {
      return Left(Failure(message: 'Failed to fetch profile'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(ProfileEntity profile) async {
    try {
      await remoteDataSource.updateProfile(profile.toModel());
      await localDataSource.saveProfile(profile.toModel());
      return Right(null);
    } catch (e) {
      return Left(Failure(message: 'Failed to update profile'));
    }
  }
}
