import 'package:carinfo/features/favourite/domain/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;

  FavouriteBloc({required this.favouriteRepository})
      : super(FavouriteInitial());

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event) async* {
    if (event is FetchFavouritesEvent) {
      yield FavouriteLoading();
      try {
        final favourites = await favouriteRepository.getFavourites();
        yield FavouriteLoaded(favourites: favourites);
      } catch (e) {
        yield FavouriteError(message: 'Failed to load favourites');
      }
    }
  }
}
