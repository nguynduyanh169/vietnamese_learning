// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_progress_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveProgressLocalAdapter extends TypeAdapter<SaveProgressLocal> {
  @override
  final int typeId = 1;

  @override
  SaveProgressLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveProgressLocal(
      lessonID: fields[0] as String,
      vocabProgress: fields[1] as double,
      converProgress: fields[2] as double,
      quizProgress: fields[3] as double,
      updateTime: fields[4] as DateTime,
      isSync: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SaveProgressLocal obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.lessonID)
      ..writeByte(1)
      ..write(obj.vocabProgress)
      ..writeByte(2)
      ..write(obj.converProgress)
      ..writeByte(3)
      ..write(obj.quizProgress)
      ..writeByte(4)
      ..write(obj.updateTime)
      ..writeByte(5)
      ..write(obj.isSync);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveProgressLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
