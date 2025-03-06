import 'package:carinfo/app/constants/hive_table_constant.dart';
import 'package:carinfo/features/car/data/data_source/car_data_source.dart';
import 'package:carinfo/features/car/data/model/car_hive_model.dart';
import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CarLocalDataSource implements ICarDataSource {
  // Add a new car
  @override
  Future<void> addCar(Car car) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    var carModel = CarHiveModel.fromEntity(car);
    await box.put(car.id, carModel);
  }

  // Delete a car by ID
  @override
  Future<void> deleteCar(String carId) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    await box.delete(carId);
  }

  // Get all cars
  @override
  Future<List<Car>> getAllCars() async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    return box.values.map((carModel) => carModel.toEntity()).toList();
  }

  // Get car by ID
  @override
  Future<Car> getCarById(String carId) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    var carModel = box.get(carId);
    if (carModel == null) {
      throw Exception("Car not found");
    }
    return carModel.toEntity();
  }

  // Update a car by ID
  @override
  Future<void> updateCar(Car car) async {
    var box = await Hive.openBox<CarHiveModel>(HiveTableConstant.carBox);
    var carModel = CarHiveModel.fromEntity(car);

    // Check if the car exists in the box
    if (box.containsKey(car.id)) {
      await box.put(car.id, carModel); // Update the existing car data
    } else {
      throw Exception('Car not found');
    }
  }
}
