// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalAdapter extends TypeAdapter<Journal> {
  @override
  final int typeId = 1;

  @override
  Journal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Journal(
      title: fields[0] as String?,
      imageByte: fields[1] as Uint8List?,
      description: fields[2] as String?,
      risk: fields[3] as String?,
      status: fields[4] as String?,
      direction: fields[5] as String?,
      selectedDateTime: fields[6] as DateTime?,
      riskReward: fields[7] as double?,
      colorValue: fields[8] as int?,
      date: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Journal obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imageByte)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.risk)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.direction)
      ..writeByte(6)
      ..write(obj.selectedDateTime)
      ..writeByte(7)
      ..write(obj.riskReward)
      ..writeByte(8)
      ..write(obj.colorValue)
      ..writeByte(9)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
