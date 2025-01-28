// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 2;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      productame: fields[0] as String,
      price: fields[1] as int,
      sellingPrice: fields[2] as int,
      ram: fields[3] as String,
      color: fields[4] as String,
      storage: fields[5] as String,
      os: fields[6] as String,
      screenSize: fields[7] as String,
      brandId: fields[8] as String,
      quatity: fields[9] as int,
      imagePath: fields[10] as String,
      productId: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.productame)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.sellingPrice)
      ..writeByte(3)
      ..write(obj.ram)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.storage)
      ..writeByte(6)
      ..write(obj.os)
      ..writeByte(7)
      ..write(obj.screenSize)
      ..writeByte(8)
      ..write(obj.brandId)
      ..writeByte(9)
      ..write(obj.quatity)
      ..writeByte(10)
      ..write(obj.imagePath)
      ..writeByte(11)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
