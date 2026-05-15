import 'package:flutter/material.dart';

import 'usage_page.dart';
import 'card_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int seciliIndex = 0;

  final List<Widget> sayfalar = [

    const HomeContent(),
    const UsagePage(),
    const CardPage(),
    const ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Akıllı Su Takip"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: sayfalar[seciliIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: seciliIndex,

        onTap: (index) {

          setState(() {

            seciliIndex = index;

          });

        },

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Ana Sayfa",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.water),
            label: "Kullanım",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Kart",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
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
    );
  }
}