import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/use_case/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
        LoginParams(email: 'test@example.com', password: 'testpassword'));
  });

  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(mockAuthRepository, mockTokenSharedPrefs);
  });

  const email = 'test@example.com';
  const password = 'password123';

  test('should return ApiFailure when login fails', () async {
    when(() => mockAuthRepository.loginUser(email, password)).thenAnswer(
      (_) async => Left(ApiFailure(message: 'Server Error', statusCode: 500)),
    );

    final result =
        await loginUseCase(LoginParams(email: email, password: password));

    expect(result, Left(ApiFailure(message: 'Server Error', statusCode: 500)));
    verify(() => mockAuthRepository.loginUser(email, password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
    verifyNoMoreInteractions(mockTokenSharedPrefs);
  });

  test('should return DuplicateEmailFailure when email is already in use',
      () async {
    when(() => mockAuthRepository.loginUser(email, password)).thenAnswer(
      (_) async => Left(DuplicateEmailFailure()),
    );

    final result =
        await loginUseCase(LoginParams(email: email, password: password));

    expect(result, Left(DuplicateEmailFailure()));
    verify(() => mockAuthRepository.loginUser(email, password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
    verifyNoMoreInteractions(mockTokenSharedPrefs);
  });

  test('should return WeakPasswordFailure when password is weak', () async {
    when(() => mockAuthRepository.loginUser(email, password)).thenAnswer(
      (_) async => Left(WeakPasswordFailure()),
    );

    final result =
        await loginUseCase(LoginParams(email: email, password: password));

    expect(result, Left(WeakPasswordFailure()));
    verify(() => mockAuthRepository.loginUser(email, password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
    verifyNoMoreInteractions(mockTokenSharedPrefs);
  });

  test('should not save token if login fails', () async {
    when(() => mockAuthRepository.loginUser(email, password)).thenAnswer(
      (_) async => Left(ApiFailure(message: 'Server Error', statusCode: 500)),
    );

    final result =
        await loginUseCase(LoginParams(email: email, password: password));

    expect(result, Left(ApiFailure(message: 'Server Error', statusCode: 500)));
    verify(() => mockAuthRepository.loginUser(email, password)).called(1);
    verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    verifyNoMoreInteractions(mockAuthRepository);
    verifyNoMoreInteractions(mockTokenSharedPrefs);
  });

  test('should return InvalidEmailFailure when email format is invalid',
      () async {
    when(() => mockAuthRepository.loginUser(any(), any())).thenAnswer(
      (_) async => Left(InvalidEmailFailure()),
    );

    const invalidEmail = 'invalidemail';
    const password = 'password123';
    final invalidParams = LoginParams(email: invalidEmail, password: password);

    final result = await loginUseCase(invalidParams);

    expect(result, Left(InvalidEmailFailure()));
    verify(() => mockAuthRepository.loginUser(invalidEmail, password))
        .called(1);
    verifyNoMoreInteractions(mockAuthRepository);
    verifyNoMoreInteractions(mockTokenSharedPrefs);
  });

  test('should return MissingFieldFailure when fields are missing', () async {
    when(() => mockAuthRepository.loginUser(any(), any())).thenAnswer(
      (_) async => Left(MissingFieldFailure()),
    );

    const missingFieldParams = LoginParams(email: '', password: '');

    final result = await loginUseCase(missingFieldParams);

    expect(result, Left(MissingFieldFailure()));
    verify(() => mockAuthRepository.loginUser('', '')).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
    verifyNoMoreInteractions(mockTokenSharedPrefs);
  });
}
