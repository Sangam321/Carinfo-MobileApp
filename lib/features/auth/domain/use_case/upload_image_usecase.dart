import 'dart:io';

import 'package:carinfo/app/usecase/usecase.dart';
import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUsecase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IAuthRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadProfilePicture(params.file);
  }
}
