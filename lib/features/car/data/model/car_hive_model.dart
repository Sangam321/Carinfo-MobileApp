import 'package:carinfo/app/constants/hive_table_constant.dart';
import 'package:carinfo/features/car_details/domain/entity/car_entity.dart';
import 'package:hive/hive.dart';

part 'car_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.carTableId)
class CarHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String carTitle;

  @HiveField(2)
  final String? subTitle;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String? carLevel;

  @HiveField(6)
  final double? carPrice;

  @HiveField(7)
  final String? carThumbnail;

  @HiveField(8)
  final List<String> enrolledUsers;

  @HiveField(9)
  final List<String> lectures;

  @HiveField(10)
  final String creator;

  @HiveField(11)
  final bool isPublished;

  @HiveField(12)
  final DateTime createdAt;

  @HiveField(13)
  final DateTime updatedAt;

  CarHiveModel({
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

  // Factory constructor to create a CarHiveModel from an entity (Car)
  factory CarHiveModel.fromEntity(Car car) {
    return CarHiveModel(
      id: car.id,
      carTitle: car.carTitle,
      subTitle: car.subTitle,
      description: car.description,
      category: car.category,
      carLevel: car.carLevel,
      carPrice: car.carPrice,
      carThumbnail: car.carThumbnail,
      enrolledUsers: car.enrolledUsers,
      lectures: car.lectures,
      creator: car.creator,
      isPublished: car.isPublished,
      createdAt: car.createdAt,
      updatedAt: car.updatedAt,
    );
  }

  // Method to convert a CarHiveModel back into an entity (Car)
  Car toEntity() {
    return Car(
      id: id,
      carTitle: carTitle,
      subTitle: subTitle,
      description: description,
      category: category,
      carLevel: carLevel,
      carPrice: carPrice,
      carThumbnail: carThumbnail,
      enrolledUsers: enrolledUsers,
      lectures: lectures,
      creator: creator,
      isPublished: isPublished,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
