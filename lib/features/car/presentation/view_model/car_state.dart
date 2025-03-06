import 'package:equatable/equatable.dart';

abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object> get props => [];
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarLoaded extends CarState {
  final List<String> cars;

  const CarLoaded(this.cars);

  @override
  List<Object> get props => [cars];
}

class CarError extends CarState {
  final String error;

  const CarError(this.error);

  @override
  List<Object> get props => [error];
}
