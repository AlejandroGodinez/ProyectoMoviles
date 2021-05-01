// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      idProd: fields[0] as String,
      name: fields[1] as String,
      amount: fields[2] as int,
      size: fields[3] as String,
      priceCh: fields[4] as double,
      priceM: fields[5] as double,
      priceG: fields[6] as double,
      type: fields[7] as String,
      urlToImage: fields[8] as String,
      description: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idProd)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.priceCh)
      ..writeByte(5)
      ..write(obj.priceM)
      ..writeByte(6)
      ..write(obj.priceG)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.urlToImage)
      ..writeByte(9)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
