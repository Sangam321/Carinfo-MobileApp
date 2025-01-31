import 'package:carinfo/app/constants/hive_table_constant.dart';
import 'package:carinfo/features/auth/data/models/auth_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}carinfo.db';

    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);

    // Check if a user with the same email already exists
    bool userExists = box.values.any((element) => element.email == auth.email);

    if (userExists) {
      throw Exception('User with this email already exists.');
    }

    // Save the user in Hive
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);

    // Search for the user that matches both email and password
    final user = box.values.firstWhere(
      (element) => element.email == email && element.password == password,
    );

    return user; // Will be null if no user found with matching credentials
  }

  Future<void> close() async {
    await Hive.close();
  }
}
