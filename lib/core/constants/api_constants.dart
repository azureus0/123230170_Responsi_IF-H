class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com';
  static const String productsEndpoint = '$baseUrl/products';
  static const String baseUrlList = 'https://dummyjson.com/products/category-list';

  static String getDetailEndpoint(int id) {
    return '$productsEndpoint/$id';
  }

  static String getProductsByCategoryEndpoint(String category) {
    return '$productsEndpoint/category/$category';
  }
}
