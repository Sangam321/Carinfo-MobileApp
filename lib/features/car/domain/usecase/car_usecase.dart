import 'package:carinfo/app/usecase/usecase.dart';
import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:carinfo/features/car/domain/repository/car_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CarParams extends Equatable {
  final Car car;

  const CarParams({required this.car});

  @override
  List<Object> get props => [car];
}

class CarUseCase implements UsecaseWithParams<void, CarParams> {
  final ICarRepository repository;

  CarUseCase(this.repository);

  // Add car
  @override
  Future<Either<Failure, void>> call(CarParams params) async {
    return repository.addCar(params.car).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (_) => Right(null),
      );
    });
  }

  // Update car
  Future<Either<Failure, void>> updateCar(CarParams params) async {
    return repository.updateCar(params.car).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (_) => Right(null),
      );
    });
  }

  // Delete car
  Future<Either<Failure, void>> deleteCar(String carId) async {
    return repository.deleteCar(carId).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (_) => Right(null),
      );
    });
  }

  // Get all cars
  Future<Either<Failure, List<Car>>> getAllCars() async {
    return repository.getAllCars().then((value) {
      return value.fold(
        (failure) => Left(failure),
        (cars) => Right(cars),
      );
    });
  }

  // Get car by ID
  Future<Either<Failure, Car>> getCarById(String carId) async {
    return repository.getCarById(carId).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (car) => Right(car),
      );
    });
  }
}
