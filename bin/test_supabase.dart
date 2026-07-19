import 'package:supabase/supabase.dart';

void main() async {
  final supabase = SupabaseClient(
    'https://fikozptvdfzfdruukoqs.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZpa296cHR2ZGZ6ZmRydXVrb3FzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQzMDc3NzEsImV4cCI6MjA5OTg4Mzc3MX0.QcFIb7d1utIEe5_cB-XBXTHl4F0XJCrujrpsy0QzdUQ',
  );

  try {
    print('Supabase uzerinde dummy kullanici olusturuluyor...');
    final response = await supabase.auth.signUp(
      email: 'botaniq_dummy_test@botaniq.app',
      password: 'DummyPassword123!',
    );
    print('BAŞARILI! Kullanici basariyla kaydedildi: ${response.user?.email}');
    print('Lutfen Supabase Dashboard -> Authentication sayfasini kontrol ediniz!');
  } catch(e) {
    print('Hata: $e');
  }
}
