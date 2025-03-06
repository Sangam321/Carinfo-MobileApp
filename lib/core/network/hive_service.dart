import 'package:carinfo/app/constants/hive_table_constant.dart';
import 'package:carinfo/core/common/internet_checker/internet_checker.dart';
import 'package:carinfo/features/auth/data/models/auth_hive_model.dart';
import 'package:carinfo/features/car/data/model/car_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  final InternetChecker _internetChecker;

  HiveService(
      this._internetChecker); // Constructor with InternetChecker dependency

  // Initialize Hive database
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}carinfo.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(CarHiveModelAdapter());
  }

  // Auth Queries
  Future<void> registerAuth(AuthHiveModel auth) async {
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
  Future<AuthHiveModel> loginAuth(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);

    // Look for the user, and throw an exception if not found
    AuthHiveModel user = box.values.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => throw Exception("User not found"),
    );

    await box.close();
    return user;
  }

  // Car Queries
  Future<void> addCar(CarHiveModel car) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    await box.put(car.id, car);
  }

  Future<void> deleteCar(String carId) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    await box.delete(carId);
  }

  Future<List<CarHiveModel>> getAllCars() async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    return box.values.toList();
  }

  Future<CarHiveModel> getCarById(String carId) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);

    CarHiveModel car = box.values.firstWhere(
      (element) => element.id == carId,
      orElse: () => throw Exception("Car not found"),
    );

    await box.close();
    return car;
  }

  // Clear all data
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.carBox);
  }

  // Close Hive connection
  Future<void> close() async {
    await Hive.close();
  }
}
