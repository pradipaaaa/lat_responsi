import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/features/spaceflight/models/content_category.dart';
import 'package:news_app/features/spaceflight/models/spaceflight_item.dart';

class SpaceflightApi {
  SpaceflightApi._();

  static const _baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  static Future<List<SpaceflightItem>> fetchItems(
    ContentCategory category,
  ) async {
    final data = await _getJson('/${category.endpoint}/?limit=20');
    final results = data['results'];

    if (results is! List) {
      throw const FormatException('Format data list tidak sesuai.');
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map(SpaceflightItem.fromJson)
        .toList();
  }

  static Future<SpaceflightItem> fetchDetail(
    ContentCategory category,
    int id,
  ) async {
    final data = await _getJson('/${category.endpoint}/$id/');
    return SpaceflightItem.fromJson(data);
  }

  static Future<Map<String, dynamic>> _getJson(String path) async {
    final uri = Uri.parse('$_baseUrl$path');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Respons API bukan object JSON.');
    }

    return decoded;
  }
}
