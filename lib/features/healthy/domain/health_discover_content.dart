enum HealthDiscoverContentType { tip, spotlight }

class HealthDiscoverContent {
  const HealthDiscoverContent({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.sortOrder,
    this.imageUrl,
    this.iconName,
    this.accentColor,
  });

  final String id;
  final HealthDiscoverContentType type;
  final String title;
  final String subtitle;
  final String body;
  final int sortOrder;
  final String? imageUrl;
  final String? iconName;
  final String? accentColor;

  factory HealthDiscoverContent.fromMap(
    Map<String, dynamic> map, {
    required String languageCode,
  }) {
    final type = switch (map['content_type']) {
      'spotlight' => HealthDiscoverContentType.spotlight,
      _ => HealthDiscoverContentType.tip,
    };

    return HealthDiscoverContent(
      id: map['id']?.toString() ?? '',
      type: type,
      title: _localizedText(map['title'], languageCode),
      subtitle: _localizedText(map['subtitle'], languageCode),
      body: _localizedText(map['body'], languageCode),
      sortOrder: (map['sort_order'] as num?)?.toInt() ?? 0,
      imageUrl: _optionalText(map['image_url']),
      iconName: _optionalText(map['icon_name']),
      accentColor: _optionalText(map['accent_color']),
    );
  }

  static String _localizedText(dynamic value, String languageCode) {
    if (value is String) {
      return value.trim();
    }
    if (value is! Map) {
      return '';
    }

    final requested = value[languageCode]?.toString().trim();
    if (requested != null && requested.isNotEmpty) {
      return requested;
    }
    for (final fallbackCode in const ['tr', 'en']) {
      final fallback = value[fallbackCode]?.toString().trim();
      if (fallback != null && fallback.isNotEmpty) {
        return fallback;
      }
    }
    for (final text in value.values) {
      final fallback = text?.toString().trim();
      if (fallback != null && fallback.isNotEmpty) {
        return fallback;
      }
    }
    return '';
  }

  static String? _optionalText(dynamic value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }
}
