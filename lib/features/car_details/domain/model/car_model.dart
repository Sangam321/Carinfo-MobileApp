import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  final int id;
  final String make;
  final String model;
  final int year;
  final String color;
  final double price;

  CarModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.price,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
