import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String? image;

  final String email;
  final String password;

  const AuthEntity({
    this.userId,
    this.image,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, image, name, email, password];
}
