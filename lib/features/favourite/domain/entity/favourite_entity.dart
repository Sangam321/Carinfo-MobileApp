class FavouriteEntity {
  final int id;
  final String name;
  final String imageUrl;

  FavouriteEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory FavouriteEntity.fromJson(Map<String, dynamic> json) {
    return FavouriteEntity(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}
