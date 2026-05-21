import 'package:flutter/material.dart';
import 'database_helper.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int toplamSu = 0;

  @override
  void initState() {
    super.initState();
    profilVerileriniYukle();
  }

  void profilVerileriniYukle() async {
    int t = await DatabaseHelper.instance.toplamSuTuketimi();
    setState(() {
      toplamSu = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profil", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1D5FFF),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Giriş yapan kullanıcının adı dinamik oldu:
            Text(
              widget.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 30),
            // Veritabanından gelen toplam su tüketimi bağlandı:
            _profilBilgiSatiri("Toplam Su Kullanımı", "$toplamSu L"),
            _profilBilgiSatiri("Aylık Ortalama", "${(toplamSu / 30).toStringAsFixed(1)} L"),
            _profilBilgiSatiri("Kayıtlı Kart Sayısı", "1"),
          ],
        ),
      ),
    );
  }

  Widget _profilBilgiSatiri(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}