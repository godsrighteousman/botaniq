import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/health_discover_content.dart';

class HealthDiscoverService {
  const HealthDiscoverService(this._client);

  final SupabaseClient _client;

  factory HealthDiscoverService.fromSupabase() {
    return HealthDiscoverService(Supabase.instance.client);
  }

  Future<List<HealthDiscoverContent>> fetchPublished({
    required String languageCode,
  }) async {
    final rows = await _client
        .from('health_discover_content')
        .select(
          'id, content_type, title, subtitle, body, image_url, '
          'icon_name, accent_color, sort_order',
        )
        .eq('is_published', true)
        .order('sort_order')
        .order('published_at', ascending: false);

    return rows
        .map(
          (row) =>
              HealthDiscoverContent.fromMap(row, languageCode: languageCode),
        )
        .where((content) => content.title.isNotEmpty)
        .toList(growable: false);
  }
}
