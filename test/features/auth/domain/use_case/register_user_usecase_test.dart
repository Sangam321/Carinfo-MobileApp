import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:carinfo/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(AuthEntity(
      fName: 'Test Name',
      email: 'test@example.com',
      password: 'testpassword',
      image: 'test.jpg',
    ));
  });

  late RegisterUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockAuthRepository);
  });

  const tParams = RegisterUserParams(
    fname: 'John Doe',
    email: 'johndoe@example.com',
    password: 'password123',
    image: 'profile.jpg',
  );

  final tAuthEntity = AuthEntity(
    fName: tParams.fname,
    email: tParams.email,
    password: tParams.password,
    image: tParams.image,
  );

  test('should call registerUser on repository with correct data', () async {
    when(() => mockAuthRepository.registerUser(any<AuthEntity>())).thenAnswer(
      (_) async => const Right<Failure, void>(null),
    );

    final result = await useCase(tParams);

    expect(result, const Right(null));
    verify(() => mockAuthRepository.registerUser(tAuthEntity));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when repository call fails', () async {
    when(() => mockAuthRepository.registerUser(any<AuthEntity>())).thenAnswer(
      (_) async => Left<Failure, void>(
        ApiFailure(statusCode: 500, message: 'Server Error'),
      ),
    );

    final result = await useCase(tParams);

    expect(result, Left(ApiFailure(statusCode: 500, message: 'Server Error')));
    verify(() => mockAuthRepository.registerUser(tAuthEntity));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when email is already in use', () async {
    when(() => mockAuthRepository.registerUser(any<AuthEntity>()))
        .thenAnswer((_) async => Left(DuplicateEmailFailure()));

    const duplicateEmailParams = RegisterUserParams(
      fname: 'Sangam Basnet',
      email: '@example.com',
      password: 'password123',
      image: 'profile.jpg',
    );

    final result = await useCase(duplicateEmailParams);

    expect(result, Left(DuplicateEmailFailure()));

    verify(() => mockAuthRepository.registerUser(any<AuthEntity>()));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
