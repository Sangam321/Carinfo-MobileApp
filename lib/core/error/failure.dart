import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

// Existing failure classes
class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class ApiFailure extends Failure {
  final int? statusCode;

  const ApiFailure({
    this.statusCode,
    required super.message,
  });
}

class SharedPrefsFailure extends Failure {
  const SharedPrefsFailure({
    required super.message,
  });
}

// New failure classes

class DuplicateEmailFailure extends Failure {
  const DuplicateEmailFailure()
      : super(message: 'The email is already in use.');
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure() : super(message: 'The password is too weak.');
}

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure() : super(message: 'The email format is invalid.');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super(message: 'There was a network issue.');
}

class MissingFieldFailure extends Failure {
  const MissingFieldFailure() : super(message: 'A required field is missing.');
}
