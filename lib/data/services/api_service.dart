import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../../core/constants/api_constants.dart';

class ApiService {
  Future<List<Product>> fetchProducts({String? category}) async {
    final url = category == null || category == 'all'
        ? ApiConstants.productsEndpoint
        : ApiConstants.getProductsByCategoryEndpoint(category);
    final uri = Uri.parse(url).replace(queryParameters: {'limit': '100'});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['products'] ?? [];
      return results.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products (status: ${response.statusCode})');
    }
  }

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse(ApiConstants.baseUrlList));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((category) => category.toString()).toList();
    } else {
      throw Exception('Failed to load categories (status: ${response.statusCode})');
    }
  }

  Future<Product> fetchProductDetail(int id) async {
    final url = ApiConstants.getDetailEndpoint(id);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load detail (status: ${response.statusCode})');
    }
  }
}
