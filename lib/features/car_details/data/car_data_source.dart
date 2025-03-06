import 'package:carinfo/core/network/api_service.dart';
import 'package:carinfo/features/car_details/domain/model/car_model.dart';

abstract class CarDataSource {
  Future<CarModel> fetchCarDetails(int carId);
}

class CarDataSourceImpl implements CarDataSource {
  final ApiService apiService;

  CarDataSourceImpl({required this.apiService});

  @override
  Future<CarModel> fetchCarDetails(int carId) async {
    try {
      final response = await apiService.getRequest('/cars/$carId');
      // Ensure response and response.data are not null
      if (response != null && response.data != null) {
        return CarModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load car details: response or data is null');
      }
    } catch (e) {
      throw Exception('Error fetching car details: $e');
    }
  }
}
