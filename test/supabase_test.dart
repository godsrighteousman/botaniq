import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  testWidgets('Test Dummy Supabase Connection', (tester) async {
    // 1. Initialize Supabase connecting to the exact same URL
    await Supabase.initialize(
      url: 'https://fikozptvdfzfdruukoqs.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpa296cHR2ZGZ6ZmRydXVrb3FzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQzMDc3NzEsImV4cCI6MjA5OTg4Mzc3MX0.QcFIb7d1utIEe5_cB-XBXTHl4F0XJCrujrpsy0QzdUQ',
    );

    final supabase = Supabase.instance.client;

    try {
      print('Supabase uzerinde dummy kullanici olusturuluyor...');
      final response = await supabase.auth.signUp(
        email: 'botaniq_dummy_test@botaniq.app',
        password: 'DummyPassword123!',
      );
      print(
        'BAŞARILI! Kullanici basariyla kaydedildi: \${response.user?.email}',
      );
      print(
        'Lutfen Supabase Dashboard -> Authentication sayfasini kontrol ediniz!',
      );
    } catch (e) {
      print('Hata: \$e');
    }
  });
}
