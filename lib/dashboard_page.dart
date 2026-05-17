import 'package:flutter/material.dart';
import 'database_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int seciliIndex = 0;

  final List<Widget> sayfalar = [
    const HomeContent(),
    const Center(child: Text("Kullanım")),
    const Center(child: Text("Kart")),
    const Center(child: Text("Profil")),
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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  String name = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final users = await DatabaseHelper.instance.getUsers();

    if (users.isNotEmpty) {
      setState(() {
        name = users.last['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            "Hoş Geldin $name 👋",
            style: const TextStyle(
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
        ],
      ),
    );
  }
}