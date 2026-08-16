class SupabaseConfig {
  SupabaseConfig._();

  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );

  static void validate() {
    if (url.trim().isEmpty || publishableKey.trim().isEmpty) {
      throw StateError(
        'Missing SUPABASE_URL or SUPABASE_ANON_KEY. '
        'Launch with --dart-define-from-file=<local-config.json>.',
      );
    }
  }
}
