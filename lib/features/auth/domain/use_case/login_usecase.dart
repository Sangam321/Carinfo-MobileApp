import 'package:carinfo/app/shared_prefs/token_shared_prefs.dart';
import 'package:carinfo/app/usecase/usecase.dart';
import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    // Save token in Shared Preferences
    final result = await repository.loginUser(params.email, params.password);
    return result.fold(
      (failure) => Left(failure),
      (token) async {
        await tokenSharedPrefs.saveToken(token);
        final savedToken = await tokenSharedPrefs.getToken();
        print(savedToken);
        return Right(token);
      },
    );
  }
}
