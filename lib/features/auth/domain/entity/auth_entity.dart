import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String? image;

  final String email;
  final String password;
  final String confirmPassword;

  const AuthEntity({
    this.userId,
    this.image,
    required this.fName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props =>
      [userId, image, fName, email, password, confirmPassword];
}
