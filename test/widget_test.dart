import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Paket adı pubspec.yaml'daki proje ismiyle eşitlendi
import 'package:akilli_su_takip/main.dart';

void main() {
  testWidgets('Uygulama baslangic testi ve Giris ekrani kontrolü', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(const MyApp());

    // Ekranda LoginPage bileşenlerinin (Başlık ve Butonlar) yüklendiğini doğrula
    expect(find.text('Akıllı Su Takip'), findsOneWidget);
    expect(find.text('Giriş Yap'), findsOneWidget);
    expect(find.text('Kayıt Ol'), findsOneWidget);

    // Giriş alanlarının (Ad ve Şifre TextField'ları) ekranda var olduğunu kontrol et
    expect(find.byType(TextField), findsNWidgets(2));
  });
}