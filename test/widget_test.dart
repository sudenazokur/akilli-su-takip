import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yeni_flutter_projem/main.dart';

void main() {
  testWidgets('App açılıyor mu testi', (WidgetTester tester) async {
    // Uygulamayı başlat
    await tester.pumpWidget(MyApp());

    // Login ekranı geliyor mu kontrol et
    expect(find.text('Giriş'), findsOneWidget);

    // Kullanıcı adı alanı var mı
    expect(find.byType(TextField), findsNWidgets(2));

    // Giriş butonu var mı
    expect(find.text('Giriş Yap'), findsOneWidget);
  });
}