import 'package:carinfo/features/favourite/data/favourite_data_source.dart';
import 'package:carinfo/features/favourite/domain/entity/favourite_entity.dart';

class FavouriteRepository {
  final FavouriteDataSource favouriteDataSource;

  FavouriteRepository({required this.favouriteDataSource});

  Future<List<FavouriteEntity>> getFavourites() async {
    return await favouriteDataSource.fetchFavourites();
  }
}
