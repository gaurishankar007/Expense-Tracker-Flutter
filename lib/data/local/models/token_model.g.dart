// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenDataAdapter extends TypeAdapter<TokenData> {
  @override
  final int typeId = 1;

  @override
  TokenData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenData(
      token: fields[0] as String,
      googleSignIn: fields[1] as bool,
      profileName: fields[2] as String,
      profilePicture: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TokenData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.googleSignIn)
      ..writeByte(2)
      ..write(obj.profileName)
      ..writeByte(3)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
