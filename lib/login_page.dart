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
      // Kullanıcıyı SQLite veritabanına kaydediyoruz
      await DatabaseHelper.instance.insertUser(username, password);
      
      if (!mounted) return;
      
      // Giriş yapan kullanıcı adını MainNavigationPage'e parametre olarak gönderiyoruz
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationPage(currentUsername: username),
        ),
      );
    } else {
      // Alanlar boş bırakılırsa kullanıcıya küçük bir uyarı göstermek için
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen kullanıcı adı ve şifre giriniz!")),
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
              const SizedBox(height: 60), 
              
              // Üst Logo ve Başlık Alanı
              Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0F2FE),
                      shape: BoxShape.circle,
                    ),
                    // YENİ LOGO LİNKİN TAM BURAYA ENTEGRE EDİLDİ:
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60), // Yuvarlak çerçevenin dışına taşmaması için
                      child: Image.network(
                        'https://media.istockphoto.com/id/1369713306/tr/vekt%C3%B6r/save-water-save-earth.jpg?s=612x612&w=0&k=20&c=St372rIT47GSKEYm_DZ8u8NdBMbmX5QiKk_u8I6vO3k=', 
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // İnternet kesintisi veya yüklenme hatası durumunda çökmesin, eski ikona dönsün
                          return const Icon(
                            Icons.water_drop_rounded,
                            size: 70,
                            color: Color(0xFF1D5FFF),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Akıllı Su Takip",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Geleceğini ve Kaynaklarını Koru",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),

              // Giriş Form Elemanları
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Kullanıcı Adı",
                        prefixIcon: const Icon(Icons.person_outline_rounded, color: Color(0xFF1D5FFF)),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF1D5FFF)),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Giriş Yap Butonu
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D5FFF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Giriş Yap",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text("veya", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 15),
                    
                    // Kayıt Ol Butonu
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: login, // Simülasyon gereği aynı fonksiyona bağlandı
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1D5FFF)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text(
                          "Kayıt Ol",
                          style: TextStyle(color: Color(0xFF1D5FFF), fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Alt Dalga Efekti Tasarımı
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