// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaksi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransaksiModelAdapter extends TypeAdapter<TransaksiModel> {
  @override
  final typeId = 0;

  @override
  TransaksiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransaksiModel(
      nominal: (fields[0] as num).toDouble(),
      kategori: fields[1] as String,
      tanggal: fields[2] as DateTime,
      jenisTransaksi: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransaksiModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nominal)
      ..writeByte(1)
      ..write(obj.kategori)
      ..writeByte(2)
      ..write(obj.tanggal)
      ..writeByte(3)
      ..write(obj.jenisTransaksi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransaksiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
