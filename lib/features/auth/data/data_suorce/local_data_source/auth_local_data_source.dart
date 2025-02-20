import 'dart:io';

import 'package:carinfo/core/network/hive_service.dart';
import 'package:carinfo/features/auth/data/data_suorce/auth_data_source.dart';
import 'package:carinfo/features/auth/data/models/auth_hive_model.dart';
import 'package:carinfo/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(AuthEntity(
      userId: "1",
      fName: "",
      email: "",
      image: null,
      password: "",
    ));
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      await _hiveService.login(email, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
