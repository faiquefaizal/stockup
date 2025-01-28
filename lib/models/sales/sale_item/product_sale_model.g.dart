// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductSaleModelAdapter extends TypeAdapter<ProductSaleModel> {
  @override
  final int typeId = 4;

  @override
  ProductSaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductSaleModel(
      productId: fields[0] as String,
      price: fields[1] as int,
      quantity: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductSaleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
