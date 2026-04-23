import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart' show Box;
import 'package:tugas2/controllers/transaksi_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  final _controller = TransaksiController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Keuangan Pribadi",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Reset Data"),
                  content: Text("Yakin ingin menghapus semua transaksi?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await TransaksiController().clearAll();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Hapus",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: _controller.boxListenable, 
          builder: (context, Box value, child) {
            //ini harus masuk ke builder agar update data transaksi
            final transaksi = value.values.toList();

            if (transaksi.isEmpty) {
              return Center(child: Text("Masih kosong"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Saldo
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Saldo",
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Rp ${_controller.balance}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Riwayat Transaksi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                // list semua transaksi
                Expanded(
                  child: ListView.builder(
                    itemCount: transaksi.length,
                    itemBuilder: (context, index) {
                      final t = transaksi[index];

                      final isExpense = t.jenisTransaksi == 'expense';

                      return ListTile(
                        leading: Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                        ),
                        title: Text(t.kategori),
                        subtitle: Text(
                          "${t.tanggal.day} ${t.tanggal.month} ${t.tanggal.year}",
                        ),
                        trailing: Text(
                          "${isExpense ? '-' : '+'} Rp ${t.nominal}",
                          style: TextStyle(
                            color: isExpense ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}