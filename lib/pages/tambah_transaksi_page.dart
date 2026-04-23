import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tugas2/models/transaksi_model.dart';
import 'package:tugas2/controllers/transaksi_controller.dart';

class TambahTransaksiPage extends StatefulWidget {
  const TambahTransaksiPage({super.key});

  @override
  State<TambahTransaksiPage> createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {
  final _amountController = TextEditingController();
  final _kategoriController = TextEditingController();
  String? type;
  
  void _dispose(){
    _amountController.dispose();
    _kategoriController.dispose();
  }

  void save() {
    double? amount = double.tryParse(_amountController.text);
    String? kategori = _kategoriController.text.trim();

    if (amount == null || amount <= 0) {
      _showSnackBar("Nominal tidak boleh kosong", Colors.red);
      return;
    };

    if (kategori.isEmpty) {
      _showSnackBar("Masukkan Keterangan", Colors.red);
      return;
    };

    if(type == null){
      _showSnackBar("Tipe transaksi belum dipilih", Colors.red);
      return;
    };

    final trx = TransaksiModel(
      nominal: amount,
      kategori: kategori,
      tanggal: DateTime.now(),
      jenisTransaksi: type!,
    );
    TransaksiController().addTransaksi(trx);
    _showSnackBar("Berhasil menyimpan data baru", Colors.green);
    _dispose();
  }
  void _showSnackBar(String msg, Color snakbarColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: snakbarColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Transaksi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )

      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Nominal
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "Nominal (Rp)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ketogori / keterangan
            TextFormField(
              controller: _kategoriController,
              decoration: InputDecoration(
                labelText: "Kategori (Makan, Gaji, dll)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // jenis transaksi
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'income', child: Text("Pemasukan")),
                DropdownMenuItem(value: 'expense', child: Text("Pengeluaran")),
              ],
              onChanged: (val) {
                setState(() {
                  type = val!;
                });
              },
            ),

            const SizedBox(height: 24),

            // tombol kirim
            Center(
              child: ElevatedButton(
                onPressed: save,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green[700],
                ),
                child: const Text("Simpan Transaksi",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}