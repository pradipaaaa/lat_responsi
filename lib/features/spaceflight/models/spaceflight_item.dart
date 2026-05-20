class SpaceflightItem {
  const SpaceflightItem({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.newsSite,
    required this.summary,
    required this.publishedAt,
    required this.authorNames,
  });

  final int id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final DateTime? publishedAt;
  final List<String> authorNames;

  factory SpaceflightItem.fromJson(Map<String, dynamic> json) {
    return SpaceflightItem(
      id: _asInt(json['id']),
      title: _asString(json['title']),
      url: _asString(json['url']),
      imageUrl: _asString(json['image_url']),
      newsSite: _asString(json['news_site']),
      summary: _asString(json['summary']),
      publishedAt: DateTime.tryParse(
        _asString(json['published_at']),
      )?.toLocal(),
      authorNames: _asAuthorNames(json['authors']),
    );
  }
}

String _asString(Object? value) => value?.toString().trim() ?? '';

int _asInt(Object? value) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

List<String> _asAuthorNames(Object? value) {
  if (value is! List) return const [];

  return value
      .whereType<Map<String, dynamic>>()
      .map((author) => _asString(author['name']))
      .where((name) => name.isNotEmpty)
      .toList();
}
