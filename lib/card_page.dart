import 'package:flutter/material.dart';
import 'database_helper.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  double bakiye = 0.0;
  List<Map<String, dynamic>> islemler = [];
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _tutarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    kartVerileriniYukle();
  }

  void kartVerileriniYukle() async {
    double b = await DatabaseHelper.instance.kartBakiyesiGetir();
    var i = await DatabaseHelper.instance.sonIslemleriGetir();
    setState(() {
      bakiye = b;
      islemler = i;
    });
  }

  void bakiyeYukle(double miktar) async {
    String kartId = _idController.text.isEmpty ? "1234 5678" : _idController.text;
    await DatabaseHelper.instance.bakiyeYukle(kartId, miktar);
    _tutarController.clear();
    kartVerileriniYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        title: const Text("Su Kartı İşlemleri", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF1D5FFF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // DÜZELTİLDİ
                    children: const [
                      Text("Su Kartı Bakiyesi", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      Icon(Icons.opacity, color: Colors.white, size: 30),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text("₺${bakiye.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text("Kart ID Gir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: "Kart ID'nizi giriniz",
                prefixIcon: const Icon(Icons.credit_card),
                suffixIcon: const Icon(Icons.qr_code_scanner),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Yükleme Miktarı", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // DÜZELTİLDİ
              children: [
                _hizliMiktarButonu(50),
                _hizliMiktarButonu(100),
                _hizliMiktarButonu(200),
                _hizliMiktarButonu(0, etiket: "Diğer"),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_tutarController.text.isNotEmpty) {
                    bakiyeYukle(double.parse(_tutarController.text));
                  } else {
                    bakiyeYukle(100.0);
                  }
                },
                icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                label: const Text("Bakiyeyi Yükle", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D5FFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // DÜZELTİLDİ
              children: const [
                Text("Son İşlemler", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text("Tümünü Gör >", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: islemler.length,
              itemBuilder: (context, index) {
                final islem = islemler[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.credit_card, color: Color(0xFF1D5FFF)),
                    ),
                    title: Text("Kart ID: ${islem['card_id']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: Text("${islem['date']}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    trailing: Text("+ ₺${islem['amount']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _hizliMiktarButonu(double miktar, {String? etiket}) {
    return InkWell(
      onTap: () {
        if (etiket == "Diğer") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Tutar Girin"),
              content: TextField(controller: _tutarController, keyboardType: TextInputType.number),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tamam"))],
            ),
          );
        } else {
          bakiyeYukle(miktar);
        }
      },
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
        child: Center(
          child: Text(
            etiket ?? "₺${miktar.toInt()}",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13), // DÜZELTİLDİ
          ),
        ),
      ),
    );
  }
}