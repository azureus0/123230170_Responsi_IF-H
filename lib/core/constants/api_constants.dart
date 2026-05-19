class ApiConstants {
  static const String baseUrl = 'https://api.spaceflightnewsapi.net/v4';
  static const String articles = '$baseUrl/articles/';
  static const String blogs = '$baseUrl/blogs/';
  static const String reports = '$baseUrl/reports/';

  /// Returns the list endpoint for a given category
  static String getEndpoint(String category) {
    switch (category) {
      case 'news':
        return articles;
      case 'blogs':
        return blogs;
      case 'reports':
        return reports;
      default:
        return articles;
    }
  }

  /// Returns the detail endpoint for a given category and article ID
  static String getDetailEndpoint(String category, int id) {
    return '${getEndpoint(category)}$id/';
  }
}