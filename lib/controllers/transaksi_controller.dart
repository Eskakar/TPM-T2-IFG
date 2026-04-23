import 'package:flutter/foundation.dart';
import 'package:tugas2/models/transaksi_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class TransaksiController {
  static final TransaksiController _instance = TransaksiController._internal(); 
  factory TransaksiController() => _instance; // Singleton, 
  TransaksiController._internal();
  //_insstance -> objectnya tunggal
  //factory selalu mengembalikan objject yang sama
  //_internal() constructor private 

  //variable atau tempat db nya
  Box<TransaksiModel> get _boxTransaksi => 
    Hive.box<TransaksiModel>('transaksi');

  //box dijadikan listenable, biar jika ada perubahan data pada db akan mentrigger fungsi
  ValueListenable<Box<TransaksiModel>> get boxListenable => _boxTransaksi.listenable();
  //box yang dijadikan list, buat perhitungan di controller ini
  List<TransaksiModel> get listTransaksi => _boxTransaksi.values.toList();

  Future<void> addTransaksi(TransaksiModel transaksi) async {
    await _boxTransaksi.add(transaksi);
  }

  Future<void> updateTransaksi(int index, TransaksiModel transaksi) async {
    await _boxTransaksi.putAt(index, transaksi);
  }

  Future<void> deleteTransaksi(int index) async {
    await _boxTransaksi.deleteAt(index);
  }

  double get totalIncome =>
      listTransaksi
          .where((t) => t.jenisTransaksi == 'income')
          .fold(0, (sum, t) => sum + t.nominal);

  double get totalExpense =>
      listTransaksi
          .where((t) => t.jenisTransaksi == 'expense')
          .fold(0, (sum, t) => sum + t.nominal);

  double get balance => totalIncome - totalExpense;
}