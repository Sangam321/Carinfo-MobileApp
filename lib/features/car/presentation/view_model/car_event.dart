import 'package:carinfo/features/car/domain/entity/car_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object> get props => [];
}

class LoadAllCarsEvent extends CarEvent {}

class AddCarEvent extends CarEvent {
  final Car car;

  const AddCarEvent(this.car);

  @override
  List<Object> get props => [car];
}

class DeleteCarEvent extends CarEvent {
  final String carId;

  const DeleteCarEvent(this.carId);

  @override
  List<Object> get props => [carId];
}
