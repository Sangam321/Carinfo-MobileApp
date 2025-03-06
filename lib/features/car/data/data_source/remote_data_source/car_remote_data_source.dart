import 'dart:convert';

import 'package:carinfo/core/error/failure.dart';
import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract interface class ICarRemoteDataSource {
  Future<Either<Failure, List<Car>>> getCarsFromApi();
  Future<Either<Failure, Car>> getCarDetails(String carId);
  Future<Either<Failure, void>> addCarToApi(Car car);
  Future<Either<Failure, void>> updateCarInApi(Car car);
  Future<Either<Failure, void>> deleteCarFromApi(String carId);
}

class CarRemoteDataSource implements ICarRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  CarRemoteDataSource({required this.client, required this.baseUrl});

  @override
  Future<Either<Failure, List<Car>>> getCarsFromApi() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cars'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Car> cars =
            data.map((carData) => Car.fromJson(carData)).toList();
        return Right(cars);
      } else {
        return Left(ApiFailure(message: "Api Failure"));
      }
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  @override
  Future<Either<Failure, Car>> getCarDetails(String carId) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/cars/$carId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Car car = Car.fromJson(data);
        return Right(car);
      } else {
        return Left(ApiFailure(message: "Api Failure"));
      }
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  @override
  Future<Either<Failure, void>> addCarToApi(Car car) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/cars'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(car.toJson()),
      );

      if (response.statusCode == 201) {
        return Right(null);
      } else {
        return Left(ApiFailure(message: "Api Failure"));
      }
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  @override
  Future<Either<Failure, void>> updateCarInApi(Car car) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/cars/${car.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(car.toJson()),
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ApiFailure(message: "Api Failure"));
      }
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCarFromApi(String carId) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/cars/$carId'),
      );

      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ApiFailure(message: "Api Failure"));
      }
    } catch (e) {
      return Left(ApiFailure(message: "Api Failure"));
    }
  }
}
