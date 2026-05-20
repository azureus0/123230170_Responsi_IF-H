import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/api_service.dart';
import '../../../shared/services/auth_service.dart';

class StoreController extends GetxController {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  final username = ''.obs;
  final products = <Product>[].obs;
  final categories = <String>[].obs;
  final selectedCategory = 'all'.obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsername();
    fetchCategories();
    fetchProducts();
  }

  Future<void> loadUsername() async {
    username.value = await _authService.getUsername();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      products.value = await _apiService.fetchProducts(
        category: selectedCategory.value,
      );
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      categories.value = ['all', ...await _apiService.fetchCategories()];
    } catch (_) {
      categories.value = ['all'];
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    fetchProducts();
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }

  void goToDetail(int id) {
    Get.toNamed('/detail', arguments: {'id': id});
  }
}
