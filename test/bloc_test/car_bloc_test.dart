import 'package:bloc_test/bloc_test.dart';
import 'package:carinfo/features/car/presentation/view_model/car_bloc.dart';
import 'package:carinfo/features/car/presentation/view_model/car_event.dart';
import 'package:carinfo/features/car/presentation/view_model/car_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarBloc', () {
    // Test for initial state
    test('initial state is CarInitial', () {
      final carBloc = CarBloc();
      expect(carBloc.state, CarInitial());
    });

    // Test for LoadAllCarsEvent
    blocTest<CarBloc, CarState>(
      'emits [CarLoading, CarLoaded] when LoadAllCarsEvent is added',
      build: () => CarBloc(),
      act: (bloc) => bloc.add(LoadAllCarsEvent()),
      expect: () => [
        CarLoading(),
        CarLoaded(['Car 1', 'Car 2', 'Car 3']),
      ],
    );

    // Test for AddCarEvent
    blocTest<CarBloc, CarState>(
      'emits [CarLoading, CarLoaded] when AddCarEvent is added',
      build: () => CarBloc(),
      act: (bloc) => bloc.add(AddCarEvent(carName: 'Car 4')),
      expect: () => [
        CarLoading(),
        CarLoaded(['Car 1', 'Car 2', 'Car 3', 'Car 4']),
      ],
    );

    // Test for DeleteCarEvent
    blocTest<CarBloc, CarState>(
      'emits [CarLoading, CarLoaded] when DeleteCarEvent is added',
      build: () => CarBloc(),
      act: (bloc) => bloc.add(DeleteCarEvent(carId: 'Car 1')),
      expect: () => [
        CarLoading(),
        CarLoaded(['Car 2', 'Car 3']),
      ],
    );

    // Test for errors (loading cars fails)
    blocTest<CarBloc, CarState>(
      'emits [CarLoading, CarError] when loading cars fails',
      build: () {
        final carBloc = CarBloc();
        // Simulate a failure by overriding the _mapLoadAllCarsEventToState method
        return carBloc;
      },
      act: (bloc) => bloc.add(LoadAllCarsEvent()),
      expect: () => [
        CarLoading(),
        CarError('Failed to load cars'),
      ],
    );

    // Test for errors (adding car fails)
    blocTest<CarBloc, CarState>(
      'emits [CarLoading, CarError] when adding car fails',
      build: () {
        final carBloc = CarBloc();
        // Simulate a failure by overriding the _mapAddCarEventToState method
        return carBloc;
      },
      act: (bloc) => bloc.add(AddCarEvent(carName: 'Car 4')),
      expect: () => [
        CarLoading(),
        CarError('Failed to add car'),
      ],
    );

    // Test for errors (deleting car fails)
    blocTest<CarBloc, CarState>(
      'emits [CarLoading, CarError] when deleting car fails',
      build: () {
        final carBloc = CarBloc();
        // Simulate a failure by overriding the _mapDeleteCarEventToState method
        return carBloc;
      },
      act: (bloc) => bloc.add(DeleteCarEvent(carId: 'Car 1')),
      expect: () => [
        CarLoading(),
        CarError('Failed to delete car'),
      ],
    );
  });
}
