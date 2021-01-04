// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_api.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseAPIAdapter extends TypeAdapter<ResponseAPI> {
  @override
  final int typeId = 0;

  @override
  ResponseAPI read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseAPI(
      name: fields[0] as String,
      response: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ResponseAPI obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.response);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseAPIAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
