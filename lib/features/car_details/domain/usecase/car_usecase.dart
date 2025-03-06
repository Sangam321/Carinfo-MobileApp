import 'package:carinfo/features/car_details/domain/entity/car_entity.dart';
import 'package:carinfo/features/car_details/domain/repository/car_repository.dart';

class GetCarDetails {
  final CarRepository repository;

  GetCarDetails({required this.repository});

  Future<Car> execute(int carId) {
    return repository.getCarDetails(carId);
  }
}
