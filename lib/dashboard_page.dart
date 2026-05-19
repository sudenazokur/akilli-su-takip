import 'package:flutter/material.dart';
import 'database_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int toplamSu = 0;
  int mutfak = 0;
  int banyo = 0;
  int tuvalet = 0;

  @override
  void initState() {
    super.initState();
    verileriYukle();
  }

  void verileriYukle() async {
    int t = await DatabaseHelper.instance.toplamSuTuketimi();
    int m = await DatabaseHelper.instance.kategoriTuketimi('Mutfak');
    int b = await DatabaseHelper.instance.kategoriTuketimi('Banyo');
    int tuv = await DatabaseHelper.instance.kategoriTuketimi('Tuvalet');

    setState(() {
      toplamSu = t;
      mutfak = m;
      banyo = b;
      tuvalet = tuv;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hoş geldin, Ayşe Yılmaz",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D5FFF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // DÜZELTİLDİ
                      children: [
                        const Text(
                          "Bugünkü Toplam\nSu Kullanımı", 
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2), 
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Hedef: 300 L", 
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "$toplamSu L", 
                      style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hızlı Bakış", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: const Text("Tümünü Gör >", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _miniKategoriKarti("Mutfak", "$mutfak L", Icons.kitchen_outlined),
                  _miniKategoriKarti("Banyo", "$banyo L", Icons.bathtub_outlined),
                  _miniKategoriKarti("Tuvalet", "$tuvalet L", Icons.wc_outlined),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Uyarı", 
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            "Mutfaktaki muslukta fazla su akışı tespit edildi!", 
                            style: TextStyle(color: Colors.black87, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Haftalık Kullanım", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 15),
              Container(
                height: 150,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _grafikCubugu("Pzt", 80),
                    _grafikCubugu("Sal", 120),
                    _grafikCubugu("Çar", 60),
                    _grafikCubugu("Per", 95),
                    _grafikCubugu("Cum", 140),
                    _grafikCubugu("Cmt", 110),
                    _grafikCubugu("Paz", 130),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniKategoriKarti(String title, String amount, IconData icon) {
    return Container(
      width: 105,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF1D5FFF), size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(amount, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _grafikCubugu(String gun, double yukseklik) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: yukseklik,
          width: 14,
          decoration: BoxDecoration(color: const Color(0xFF38BDF8), borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(height: 8),
        Text(gun, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}