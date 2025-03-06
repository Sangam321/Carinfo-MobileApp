import 'package:carinfo/features/car/domain/entity/car_entity.dart';

abstract interface class ICarDataSource {
  Future<void> addCar(Car car);

  Future<void> deleteCar(String carId);

  Future<List<Car>> getAllCars();
  Future<void> updateCar(Car car);

  Future<Car> getCarById(String carId);
}
