import 'dart:io';

import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/repository/auth_repository.dart';
import 'package:carinfo/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UploadImageUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    registerFallbackValue(File('dummy/path/to/image.jpg'));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = UploadImageUsecase(mockAuthRepository);
  });

  var tFile = File('assets/images/logo.png');

  test('should upload image successfully and return the URL', () async {
    const expectedUrl = 'https://example.com/uploaded_image.jpg';
    when(() => mockAuthRepository.uploadProfilePicture(any<File>())).thenAnswer(
      (_) async => const Right(expectedUrl),
    );

    final result = await usecase(UploadImageParams(file: tFile));

    expect(result, const Right(expectedUrl));
    verify(() => mockAuthRepository.uploadProfilePicture(tFile));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when image upload fails', () async {
    const failure = ApiFailure(message: 'Failed to upload image');
    when(() => mockAuthRepository.uploadProfilePicture(any<File>())).thenAnswer(
      (_) async => Left(failure),
    );

    final result = await usecase(UploadImageParams(file: tFile));

    expect(result, Left(failure));
    verify(() => mockAuthRepository.uploadProfilePicture(tFile));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
