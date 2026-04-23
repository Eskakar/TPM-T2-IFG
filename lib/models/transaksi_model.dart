import 'package:hive_ce/hive_ce.dart';

part 'transaksi_model.g.dart';

@HiveType(typeId: 0)
  class TransaksiModel extends HiveObject {
    @HiveField(0)
    double nominal;

    @HiveField(1)
    String kategori;

    @HiveField(2)
    DateTime tanggal;

    @HiveField(3)
    String jenisTransaksi; // Pemasukan/Pengeluaran

    TransaksiModel({
      required this.nominal,
      required this.kategori,
      required this.tanggal,
      required this.jenisTransaksi,
    });
}