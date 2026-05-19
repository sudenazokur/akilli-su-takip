import 'package:flutter/material.dart';

class UsagePage extends StatelessWidget {
  const UsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          title: const Text("Su Kullanım Detayları", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          centerTitle: true,
          actions: [
            IconButton(icon: const Icon(Icons.calendar_month_outlined, color: Colors.black), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 45,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                child: TabBar(
                  indicator: BoxDecoration(color: const Color(0xFF1D5FFF), borderRadius: BorderRadius.circular(10)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: const [Tab(text: "Günlük"), Tab(text: "Haftalık"), Tab(text: "Aylık")],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // DÜZELTİLDİ
                children: [
                  Icon(Icons.chevron_left, color: Colors.grey.shade600),
                  const Text("Bugün, 7 Mart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Icon(Icons.chevron_right, color: Colors.grey.shade600),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _detayliKullanimKarti("Mutfak", "120 L", 0.8, "Yüksek", Colors.orange),
                  _detayliKullanimKarti("Banyo", "80 L", 0.5, "Normal", Colors.blue),
                  _detayliKullanimKarti("Tuvalet", "45 L", 0.3, "Normal", Colors.blue),
                  _detayliKullanimKarti("Çamaşır Makinesi", "20 L", 0.15, "Normal", Colors.blue),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detayliKullanimKarti(String baslik, String litre, double oran, String durum, Color durumRenk) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // DÜZELTİLDİ
                  children: [
                    Text(baslik, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: durumRenk.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(durum, style: TextStyle(color: durumRenk, fontSize: 10, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: oran,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1D5FFF)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 25),
          Text(litre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}