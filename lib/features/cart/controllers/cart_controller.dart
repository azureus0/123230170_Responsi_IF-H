import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/api_service.dart';
import '../../../shared/services/cart_service.dart';

class CartController extends GetxController {
  final ApiService _apiService = ApiService();
  final CartService _cartService = CartService();

  final products = <Product>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartProducts();
  }

  Future<void> fetchCartProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final ids = await _cartService.getCartProductIds();
      final results = await Future.wait(
        ids.map((id) => _apiService.fetchProductDetail(id)),
      );
      products.value = results;
    } catch (_) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void goToDetail(int id) {
    Get.toNamed('/detail', arguments: {'id': id})?.then(
      (_) => fetchCartProducts(),
    );
  }
}
