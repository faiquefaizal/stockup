// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessProfileAdapter extends TypeAdapter<BusinessProfile> {
  @override
  final int typeId = 0;

  @override
  BusinessProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusinessProfile(
      shopimage: fields[4] as String,
      shopname: fields[0] as String,
      shopnumber: fields[1] as String,
      shopemail: fields[2] as String,
      shopaddress: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BusinessProfile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.shopname)
      ..writeByte(1)
      ..write(obj.shopnumber)
      ..writeByte(2)
      ..write(obj.shopemail)
      ..writeByte(3)
      ..write(obj.shopaddress)
      ..writeByte(4)
      ..write(obj.shopimage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
