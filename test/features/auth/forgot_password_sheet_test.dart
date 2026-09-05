import 'package:botaniq/features/auth/presentation/pages/login_page.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// "Şifremi Unuttum" sayfasında gönderim başarısız olduğunda düğmenin
/// dönen göstergede takılı kalmaması gerekir — kullanıcı tekrar
/// deneyebilmeli.
void main() {
  testWidgets('gönderim hata verdiğinde düğme tekrar denenebilir olur', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoginPage(initialEmail: 'kullanici@ornek.com'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Şifreni mi unuttun?').last);
    await tester.pumpAndSettle();

    // Sayfa açıldı mı
    expect(find.text('Bağlantı Gönder'), findsOneWidget);

    // Supabase testte başlatılmadığı için gönderim hata verecek; önemli
    // olan hatadan sonra düğmenin yeniden kullanılabilir olması.
    await tester.tap(find.text('Bağlantı Gönder'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(
      find.text('Bağlantı Gönder'),
      findsOneWidget,
      reason: 'hata sonrası düğme metni geri gelmeli, spinner takılı kalmamalı',
    );
  });
}
