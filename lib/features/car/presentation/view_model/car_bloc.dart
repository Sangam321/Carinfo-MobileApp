import 'package:carinfo/features/car/presentation/view_model/car_event.dart';
import 'package:carinfo/features/car/presentation/view_model/car_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(CarInitial());

  @override
  Stream<CarState> mapEventToState(CarEvent event) async* {
    if (event is LoadAllCarsEvent) {
      yield* _mapLoadAllCarsEventToState();
    } else if (event is AddCarEvent) {
      yield* _mapAddCarEventToState(event.carName);
    } else if (event is DeleteCarEvent) {
      yield* _mapDeleteCarEventToState(event.carId);
    }
  }

  Stream<CarState> _mapLoadAllCarsEventToState() async* {
    yield CarLoading();
    try {
      // Simulate loading cars from a repository or database
      await Future.delayed(Duration(seconds: 2)); // Simulate delay
      yield CarLoaded(['Car 1', 'Car 2', 'Car 3']);
    } catch (e) {
      yield CarError("Failed to load cars");
    }
  }

  Stream<CarState> _mapAddCarEventToState(String carName) async* {
    yield CarLoading();
    try {
      // Simulate adding a car
      await Future.delayed(Duration(seconds: 1)); // Simulate delay
      yield CarLoaded(['Car 1', 'Car 2', 'Car 3', carName]);
    } catch (e) {
      yield CarError("Failed to add car");
    }
  }

  Stream<CarState> _mapDeleteCarEventToState(String carId) async* {
    yield CarLoading();
    try {
      // Simulate deleting a car
      await Future.delayed(Duration(seconds: 1)); // Simulate delay
      yield CarLoaded(['Car 1', 'Car 2']); // Update list after deletion
    } catch (e) {
      yield CarError("Failed to delete car");
    }
  }
}
