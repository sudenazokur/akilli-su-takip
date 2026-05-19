import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'main_navigation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      await DatabaseHelper.instance.insertUser(username, password);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 60), // Üst boşluk dengelendi
              
              // Üst Logo ve Başlık Alanı
              Column(
                children: [
                  Container(
                    height: 120, // iStock görselinin tam oturması için boyut 120 yapıldı
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://media.istockphoto.com/id/1369713306/tr/vekt%C3%B6r/save-water-save-earth.jpg?s=612x612&w=0&k=20&c=St372rIT47GSKEYm_DZ8u8NdBMbmX5QiKk_u8I6vO3k='), 
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // Logo ile başlık arası şık bir boşluk
                  const Text(
                    "Akıllı Su Takip",
                    style: TextStyle(
                      fontSize: 28, 
                      fontWeight: FontWeight.bold, 
                      color: Color(0xFF0F172A),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              
              // Input Alanları
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline),
                        labelText: "Ad",
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        labelText: "Şifre",
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D5FFF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("Giriş Yap", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text("veya", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1D5FFF)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("Kayıt Ol", style: TextStyle(color: Color(0xFF1D5FFF), fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Alt Dalga Tasarımı Efekti
              Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE0F2FE), Color(0xFF38BDF8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(200, 40)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}