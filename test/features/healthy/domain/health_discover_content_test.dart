import 'package:botaniq/features/healthy/domain/health_discover_content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses requested locale and falls back to available content', () {
    final content = HealthDiscoverContent.fromMap({
      'id': 'content-id',
      'content_type': 'tip',
      'title': {'tr': 'Nem Dengesi', 'en': 'Humidity Balance'},
      'subtitle': {'tr': 'Türkçe açıklama'},
      'body': <String, String>{},
      'sort_order': 3,
    }, languageCode: 'en');

    expect(content.title, 'Humidity Balance');
    expect(content.subtitle, 'Türkçe açıklama');
    expect(content.sortOrder, 3);
  });
}
