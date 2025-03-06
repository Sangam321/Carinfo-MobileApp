import 'dart:io';

import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class ICarRepository {
  Future<Either<Failure, void>> addCar(Car car);
  Future<Either<Failure, Car>> getCarById(String carId);
  Future<Either<Failure, List<Car>>> getAllCars();
  Future<Either<Failure, void>> updateCar(Car car);
  Future<Either<Failure, void>> deleteCar(String carId);
  Future<Either<Failure, String>> uploadCarThumbnail(File file);
}
