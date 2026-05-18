import 'package:flutter/material.dart';
import 'database_helper.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Su Takip"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // TOPLAM SU GÖSTERME
            FutureBuilder<int>(
              future: DatabaseHelper.instance.toplamSu(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                return Text(
                  "${snapshot.data} ml",
                  style: TextStyle(fontSize: 32),
                );
              },
            ),

            SizedBox(height: 30),

            // BUTON
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.suEkle(250);
                setState(() {});
              },
              child: Text("250 ml ekle"),
            ),

          ],
        ),
      ),
    );
  }
}