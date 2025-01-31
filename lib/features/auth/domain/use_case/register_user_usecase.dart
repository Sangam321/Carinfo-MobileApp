import 'package:carinfo/app/usecase/usecase.dart';
import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:carinfo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String email;
  final String password;
  final String confirmPassword;
  final String? image;

  const RegisterUserParams({
    required this.fname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.image,
  });

  @override
  List<Object?> get props => [fname, email, password, confirmPassword];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fName: params.fname,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
