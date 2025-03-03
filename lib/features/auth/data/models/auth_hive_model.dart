import 'package:carinfo/app/constants/hive_table_constant.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.name,
    this.image,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        name = '',
        image = '',
        email = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      name: entity.name,
      image: entity.image,
      email: entity.email,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      name: name,
      image: image,
      email: email,
      password: password,
    );
  }

  @override
  List<Object?> get props => [userId, name, image, email, password];
}
