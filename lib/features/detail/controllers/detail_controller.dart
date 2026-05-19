import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/article_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/services/notification_service.dart';

class DetailController extends GetxController {
  final ApiService _apiService = ApiService();
  final NotificationService _notificationService = NotificationService();

  final article = Rxn<Article>();
  final isLoading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    fetchDetail(args['category'], args['id']);
  }

  /// Fetch article detail from API
  Future<void> fetchDetail(String category, int id) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final result = await _apiService.fetchArticleDetail(category, id);
      article.value = result;

      // Show notification when article is opened
      await _notificationService.showNotification(
        id: 3,
        title: 'Sedang Membaca 📖',
        body: result.title,
      );
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  /// Open the article URL in external browser
  Future<void> openUrl() async {
    if (article.value != null) {
      final uri = Uri.parse(article.value!.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }
}
