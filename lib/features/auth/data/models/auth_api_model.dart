import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fname;
  final String email;

  final String? image;

  final String? confirmPassword;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.email,
    required this.image,
    required this.password,
    required this.confirmPassword,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fName: fname,
      email: email,
      image: image,
      password: password ?? '',
      confirmPassword: confirmPassword ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fname: entity.fName,
      email: entity.email,
      image: entity.image,
      confirmPassword: entity.confirmPassword,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [id, fname, email, image, confirmPassword, password];
}
