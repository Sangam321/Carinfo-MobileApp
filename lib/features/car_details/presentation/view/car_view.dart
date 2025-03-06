// Make sure you have GetCarDetails available to pass to the Bloc.
import 'package:carinfo/features/car_details/domain/usecase/car_usecase.dart';
import 'package:carinfo/features/car_details/presentation/view_model/car_bloc.dart';
import 'package:carinfo/features/car_details/presentation/view_model/car_event.dart';
import 'package:carinfo/features/car_details/presentation/view_model/car_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarView extends StatelessWidget {
  final int carId;

  const CarView({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    // Assuming GetCarDetails is available in the context or needs to be instantiated.
    final getCarDetails = GetCarDetails();

    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: BlocProvider(
        create: (context) => CarBloc(getCarDetails: getCarDetails)
          ..add(FetchCarDetailsEvent(carId: carId)),
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CarLoadedState) {
              final car = state.car;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Make: ${car.make}', style: TextStyle(fontSize: 20)),
                    Text('Model: ${car.model}', style: TextStyle(fontSize: 20)),
                    Text('Year: ${car.year}', style: TextStyle(fontSize: 20)),
                    Text('Color: ${car.color}', style: TextStyle(fontSize: 20)),
                    Text('Price: \$${car.price}',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              );
            } else if (state is CarErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
