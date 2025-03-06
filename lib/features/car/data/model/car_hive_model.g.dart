// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarHiveModelAdapter extends TypeAdapter<CarHiveModel> {
  @override
  final int typeId = 1;

  @override
  CarHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarHiveModel(
      id: fields[0] as String,
      carTitle: fields[1] as String,
      subTitle: fields[2] as String?,
      description: fields[3] as String?,
      category: fields[4] as String,
      carLevel: fields[5] as String?,
      carPrice: fields[6] as double?,
      carThumbnail: fields[7] as String?,
      enrolledUsers: (fields[8] as List).cast<String>(),
      lectures: (fields[9] as List).cast<String>(),
      creator: fields[10] as String,
      isPublished: fields[11] as bool,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CarHiveModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carTitle)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.carLevel)
      ..writeByte(6)
      ..write(obj.carPrice)
      ..writeByte(7)
      ..write(obj.carThumbnail)
      ..writeByte(8)
      ..write(obj.enrolledUsers)
      ..writeByte(9)
      ..write(obj.lectures)
      ..writeByte(10)
      ..write(obj.creator)
      ..writeByte(11)
      ..write(obj.isPublished)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
