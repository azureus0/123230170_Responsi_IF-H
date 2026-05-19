import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';
import '../../core/constants/api_constants.dart';

class ApiService {
  /// Fetch list of articles for a given category (news, blogs, reports)
  Future<List<Article>> fetchArticles(String category) async {
    final url = ApiConstants.getEndpoint(category);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'] ?? [];
      return results.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load $category (status: ${response.statusCode})');
    }
  }

  /// Fetch a single article detail by category and ID
  Future<Article> fetchArticleDetail(String category, int id) async {
    final url = ApiConstants.getDetailEndpoint(category, id);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Article.fromJson(data);
    } else {
      throw Exception('Failed to load detail (status: ${response.statusCode})');
    }
  }
}