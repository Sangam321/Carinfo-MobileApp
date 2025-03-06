import 'package:carinfo/app/constants/hive_table_constant.dart';
import 'package:carinfo/core/common/internet_checker/internet_checker.dart'; // Import the InternetChecker
import 'package:carinfo/features/auth/data/models/auth_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  final InternetChecker _internetChecker; // Add a reference to InternetChecker

  HiveService(
      this._internetChecker); // Constructor with InternetChecker dependency

  // Initialize Hive database
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}carinfo.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    // Before registering, check for internet connection
    bool isConnected = await _internetChecker.isConnected();
    if (!isConnected) {
      throw Exception("No internet connection. Please try again later.");
    }

    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
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

  // Login using email and password with internet check
  Future<AuthHiveModel> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);

    // Look for the user, and throw an exception if not found
    AuthHiveModel user = box.values.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => throw Exception(
          "User not found"), // Throw exception if no match is found
    );

    await box.close();
    return user; // This will always return a valid user or throw an exception
  }

  // Clear all data
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear user Box
  Future<void> clearuserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Close Hive connection
  Future<void> close() async {
    await Hive.close();
  }
}
