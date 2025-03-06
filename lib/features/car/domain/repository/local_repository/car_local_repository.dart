import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/car/data/data_source/local_data_source/car_local_data_source.dart';
import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';

class CarLocalRepository {
  final CarLocalDataSource localDataSource;

  CarLocalRepository({required this.localDataSource});

  Future<Either<Failure, List<Car>>> getCars() async {
    try {
      final cars = await localDataSource.getAllCars();
      return Right(cars);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Local Database failure"));
    }
  }

  Future<Either<Failure, Car>> getCarById(String id) async {
    try {
      final car = await localDataSource.getCarById(id);
      return Right(car);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Local Database failure"));
    }
  }

  Future<Either<Failure, void>> addCar(Car car) async {
    try {
      await localDataSource.addCar(car);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Local Database failure"));
    }
  }

  Future<Either<Failure, void>> updateCar(Car car) async {
    try {
      await localDataSource.updateCar(car);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Local Database failure"));
    }
  }

  Future<Either<Failure, void>> deleteCar(String id) async {
    try {
      await localDataSource.deleteCar(id);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Local Database failure"));
    }
  }
}
