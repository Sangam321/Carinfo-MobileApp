import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(String username, String password);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
