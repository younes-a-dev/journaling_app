// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 3;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as int,
      content: fields[1] as String,
      dateTime: fields[2] as DateTime,
      isChecked: fields[3] as bool,
      alarmID: fields[4] as int?,
      secendsToRemind: fields[5] as int?,
      timeOfRemider: fields[6] as String?,
      createdDate: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.isChecked)
      ..writeByte(4)
      ..write(obj.alarmID)
      ..writeByte(5)
      ..write(obj.secendsToRemind)
      ..writeByte(6)
      ..write(obj.timeOfRemider)
      ..writeByte(7)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
