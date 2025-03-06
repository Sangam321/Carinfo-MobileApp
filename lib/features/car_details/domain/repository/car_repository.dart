import 'package:carinfo/features/car_details/data/car_data_source.dart';
import 'package:carinfo/features/car_details/domain/entity/car_entity.dart';

abstract class CarRepository {
  Future<Car> getCarDetails(int carId);
}

class CarRepositoryImpl implements CarRepository {
  final CarDataSource carDataSource;

  CarRepositoryImpl({required this.carDataSource});

  @override
  Future<Car> getCarDetails(int carId) async {
    final carModel = await carDataSource.fetchCarDetails(carId);
    return Car(
      id: carModel.id,
      make: carModel.make,
      model: carModel.model,
      year: carModel.year,
      color: carModel.color,
      price: carModel.price,
    );
  }
}
