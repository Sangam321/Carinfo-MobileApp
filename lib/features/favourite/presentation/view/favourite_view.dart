import 'package:carinfo/features/favourite/domain/entity/favourite_entity.dart';
import 'package:carinfo/features/favourite/domain/repository/favourite_repository.dart';
import 'package:carinfo/features/favourite/presentation/view_model/favourite_bloc.dart';
import 'package:carinfo/features/favourite/presentation/view_model/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: BlocProvider(
        create: (context) => FavouriteBloc(
            favouriteRepository:
                RepositoryProvider.of<FavouriteRepository>(context)),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            if (state is FavouriteLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavouriteLoaded) {
              return ListView.builder(
                itemCount: state.favourites.length,
                itemBuilder: (context, index) {
                  final FavouriteEntity favourite = state.favourites[index];
                  return ListTile(
                    leading: Image.network(favourite.imageUrl),
                    title: Text(favourite.name),
                  );
                },
              );
            } else if (state is FavouriteError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
