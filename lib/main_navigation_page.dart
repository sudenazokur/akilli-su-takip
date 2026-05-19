import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'usage_page.dart';
import 'card_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  // Tasarımdaki 5 sekmeli yapıyı tam olarak buraya entegre ettik
  final List<Widget> _pages = [
    DashboardPage(), // Üzerinde const hatası kalmaması için dinamik bırakıldı
    const UsagePage(),
    const CardPage(),
    const Scaffold(body: Center(child: Text("Uyarılar Çok Yakında!"))),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1D5FFF), // Tasarımdaki aktif canlı mavi renk
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: "Kullanım"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card_rounded), label: "Kartlar"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), label: "Uyarılar"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profil"),
        ],
      ),
    );
  }
}