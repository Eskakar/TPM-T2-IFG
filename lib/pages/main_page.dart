import 'package:flutter/material.dart';
import 'home.dart';
import 'tambah_transaksi_page.dart';
import 'konversi_kurs_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    TambahTransaksiPage(),
    KonversiKursPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 111, 0),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Tambah",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Kurs API",
          ),
        ],
      ),
    );
  }
}