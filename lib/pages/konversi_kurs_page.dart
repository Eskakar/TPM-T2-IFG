import 'package:flutter/material.dart';
import 'package:tugas2/services/kurs_service.dart';

class KonversiKursPage extends StatefulWidget {
  const KonversiKursPage({super.key});

  @override
  State<KonversiKursPage> createState() => _KonversiKursPageState();
}

class _KonversiKursPageState extends State<KonversiKursPage> {
  final _rupiahController = TextEditingController();
  String _matauang = "USD";
  double _converted = 0;

  Map<String,IconData> jenisUang = {
    "USD" : Icons.attach_money,
    "EUR" : Icons.euro,
    "JPY" : Icons.currency_yen
  };

  Future<void> konversi()async{
    final input = _rupiahController.text.trim();
    _converted = 0;
    // validasi input kosong
    if (input.isEmpty) {
      _showSnackBar('Input tidak boleh kosong', Colors.red);
      return;
    }
    final double? uang = double.tryParse(input);

    if (uang == null) {
      _showSnackBar('Input hanya boleh angka', Colors.red);
      return;
    }

    // Validasi bilangan negatif
    if (uang < 0) {
      _showSnackBar('Masukkan nilai non-negatif', Colors.red);
      return;
    }

    try{
      double n = await KursService.convertIDR(uang, _matauang);
      setState((){
        _converted = n;
      });
      
    }catch(e){
      _showSnackBar('Terjadi kesalahan: ${e.toString()}', Colors.red);
    }
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
        title: Text("Konversi Mata Uang",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // input nominal uang
          TextField(
            controller: _rupiahController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: "Rp ",
              hintText: "Input jumlah uang...",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // janis mata uang
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'USD', child: Text("USD")),
              DropdownMenuItem(value: 'EUR', child: Text("EURO")),
              DropdownMenuItem(value: 'JPY', child: Text("YEN")),
            ],
            onChanged: (val) {
              setState(() {
                _matauang = val!;
              });
            },
          ),

          const SizedBox(height: 20),

          // tombol kirim
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43B89C),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: konversi,
              icon: const Icon(Icons.sync),
              label: const Text(
                'Konversi',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // kontainer hasil
          if (_converted != 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF43B89C),
                    const Color(0xFF2FAF90),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Hasil Konversi",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        jenisUang[_matauang] ?? Icons.money,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _converted.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
    );
  }
}