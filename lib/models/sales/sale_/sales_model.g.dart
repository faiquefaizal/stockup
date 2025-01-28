// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesModelAdapter extends TypeAdapter<SalesModel> {
  @override
  final int typeId = 3;

  @override
  SalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesModel(
      custumerName: fields[0] as String,
      phoneNumber: fields[1] as String,
      saleDate: fields[2] as DateTime,
      productCount: fields[3] as int,
      totalSalePrice: fields[4] as double,
      saleId: fields[5] as String,
      saleProducts: (fields[6] as List).cast<ProductSaleModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SalesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.custumerName)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.saleDate)
      ..writeByte(3)
      ..write(obj.productCount)
      ..writeByte(4)
      ..write(obj.totalSalePrice)
      ..writeByte(5)
      ..write(obj.saleId)
      ..writeByte(6)
      ..write(obj.saleProducts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
