class Car {
  final String id;
  final String carTitle;
  final String? subTitle;
  final String? description;
  final String category;
  final String? carLevel;
  final double? carPrice;
  final String? carThumbnail;
  final List<String> enrolledUsers;
  final List<String> lectures;
  final String creator;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;

  Car({
    required this.id,
    required this.carTitle,
    this.subTitle,
    this.description,
    required this.category,
    this.carLevel,
    this.carPrice,
    this.carThumbnail,
    required this.enrolledUsers,
    required this.lectures,
    required this.creator,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'] ?? '',
      carTitle: json['carTitle'] ?? '',
      subTitle: json['subTitle'],
      description: json['description'],
      category: json['category'] ?? '',
      carLevel: json['carLevel'],
      carPrice: json['carPrice']?.toDouble(),
      carThumbnail: json['carThumbnail'],
      enrolledUsers: List<String>.from(json['enrolledUsers'] ?? []),
      lectures: List<String>.from(json['lectures'] ?? []),
      creator: json['creator'] ?? '',
      isPublished: json['isPublished'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'carTitle': carTitle,
      'subTitle': subTitle,
      'description': description,
      'category': category,
      'carLevel': carLevel,
      'carPrice': carPrice,
      'carThumbnail': carThumbnail,
      'enrolledUsers': enrolledUsers,
      'lectures': lectures,
      'creator': creator,
      'isPublished': isPublished,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
