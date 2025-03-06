import 'dart:convert';

import 'package:carinfo/features/favourite/domain/entity/favourite_entity.dart';
import 'package:http/http.dart' as http;

class FavouriteDataSource {
  final String apiUrl = 'https://yourapi.com/favourites'; // Your API endpoint

  Future<List<FavouriteEntity>> fetchFavourites() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData
            .map((data) => FavouriteEntity.fromJson(data))
            .toList();
      } else {
        throw Exception('Failed to load favourites');
      }
    } catch (e) {
      throw Exception('Error fetching favourites: $e');
    }
  }
}
