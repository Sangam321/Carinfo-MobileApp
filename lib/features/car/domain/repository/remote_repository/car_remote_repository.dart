import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/car/data/data_source/remote_data_source/car_remote_data_source.dart';
import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';

class CarRemoteRepository {
  final CarRemoteDataSource remoteDataSource;

  CarRemoteRepository({required this.remoteDataSource});

  Future<Either<Failure, List<Car>>> getCars() async {
    try {
      final cars = await remoteDataSource.getCarsFromApi();
      return cars;
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  Future<Either<Failure, Car>> getCarById(String id) async {
    try {
      final car = await remoteDataSource.getCarDetails(id);
      return car;
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  Future<Either<Failure, void>> addCar(Car car) async {
    try {
      await remoteDataSource.addCarToApi(car);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  Future<Either<Failure, void>> updateCar(Car car) async {
    try {
      await remoteDataSource.updateCarInApi(car);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  Future<Either<Failure, void>> deleteCar(String id) async {
    try {
      await remoteDataSource.deleteCarFromApi(id);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }
}
