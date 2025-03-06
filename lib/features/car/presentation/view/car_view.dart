import 'package:carinfo/features/car/presentation/view_model/car_bloc.dart';
import 'package:carinfo/features/car/presentation/view_model/car_event.dart';
import 'package:carinfo/features/car/presentation/view_model/car_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarView extends StatelessWidget {
  const CarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocProvider(
        create: (context) => CarBloc()..add(LoadAllCarsEvent()), // Initial load
        child: CarBody(),
      ),
    );
  }
}

class CarBody extends StatelessWidget {
  const CarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        if (state is CarLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CarError) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state is CarLoaded) {
          return ListView.builder(
            itemCount: state.cars.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.cars[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<CarBloc>()
                        .add(DeleteCarEvent(state.cars[index]));
                  },
                ),
              );
            },
          );
        }

        return Container(); // Initial state (empty)
      },
    );
  }
}
