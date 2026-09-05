import 'package:botaniq/features/auth/presentation/pages/reset_password_page.dart';
import 'package:botaniq/features/auth/presentation/pages/verify_email_page.dart';
import 'package:botaniq/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  locale: const Locale('tr'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

void main() {
  testWidgets('ResetPasswordPage (kod ile) hatasız çizilir ve durulur', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const ResetPasswordPage(email: 'a@b.com')));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('ResetPasswordPage (deep link) hatasız çizilir ve durulur', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const ResetPasswordPage()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('VerifyEmailPage hatasız çizilir ve durulur', (tester) async {
    await tester.pumpWidget(_wrap(const VerifyEmailPage(email: 'a@b.com')));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
