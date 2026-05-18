import 'package:flutter/material.dart';
import 'database_helper.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int toplam = 0;

  @override
  void initState() {
    super.initState();
    veriGetir();
  }

  void veriGetir() async {
    int t = await DatabaseHelper.instance.toplamSu();
    setState(() {
      toplam = t;
    });
  }

  void suEkle(int miktar) async {
    await DatabaseHelper.instance.suEkle(miktar);
    veriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Toplam Su: $toplam ml", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => suEkle(250),
              child: Text("250 ml ekle"),
            ),
          ],
        ),
      ),
    );
  }
}