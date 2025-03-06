import 'package:carinfo/features/favourite/domain/entity/favourite_entity.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<FavouriteEntity> favourites;

  FavouriteLoaded({required this.favourites});
}

class FavouriteError extends FavouriteState {
  final String message;

  FavouriteError({required this.message});
}
