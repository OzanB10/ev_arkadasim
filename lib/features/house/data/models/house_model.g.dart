// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseModelAdapter extends TypeAdapter<HouseModel> {
  @override
  final int typeId = 0;

  @override
  HouseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HouseModel()
      ..houseId = fields[0] as String
      ..name = fields[1] as String
      ..code = fields[2] as String
      ..memberIds = (fields[3] as List).cast<String>()
      ..createdAt = fields[4] as DateTime
      ..updatedAt = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HouseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.houseId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.memberIds)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
