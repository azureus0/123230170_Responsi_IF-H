import 'package:get/get.dart';
import '../../../data/models/article_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/services/notification_service.dart';

class ListController extends GetxController {
  final ApiService _apiService = ApiService();
  final NotificationService _notificationService = NotificationService();

  final articles = <Article>[].obs;
  final isLoading = true.obs;
  final category = ''.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    category.value = Get.arguments ?? 'news';
    fetchArticles();
  }

  /// Fetch articles from API based on category
  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final result = await _apiService.fetchArticles(category.value);
      articles.value = result;

      // Show notification
      await _notificationService.showNotification(
        id: 2,
        title: 'Data Dimuat! 📰',
        body: '${result.length} ${getCategoryTitle()} berhasil dimuat.',
      );
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the localized title for current category
  String getCategoryTitle() {
    switch (category.value) {
      case 'news':
        return 'Berita Terkini';
      case 'blogs':
        return 'Blog Terkini';
      case 'reports':
        return 'Report Terkini';
      default:
        return 'Articles';
    }
  }

  /// Navigate to detail page
  void goToDetail(int id) {
    Get.toNamed('/detail', arguments: {
      'category': category.value,
      'id': id,
    });
  }
}
