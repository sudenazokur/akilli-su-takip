import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Ana Sayfa"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Hoş Geldin 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    "Bugünkü Su Kullanımı",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "245 L",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Bölgelere Göre Kullanım",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            suKarti("Mutfak", "120 L", Icons.kitchen),
            suKarti("Banyo", "80 L", Icons.bathtub),
            suKarti("Tuvalet", "45 L", Icons.wc),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Mutfakta fazla su kullanımı tespit edildi!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget suKarti(String alan, String litre, IconData ikon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),

      child: ListTile(
        leading: Icon(
          ikon,
          color: Colors.blue,
          size: 35,
        ),

        title: Text(alan),

        trailing: Text(
          litre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}