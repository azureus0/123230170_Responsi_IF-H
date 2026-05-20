import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/api_service.dart';
import '../../../shared/services/cart_service.dart';

class DetailController extends GetxController {
  final ApiService _apiService = ApiService();
  final CartService _cartService = CartService();

  final product = Rxn<Product>();
  final isLoading = true.obs;
  final hasError = false.obs;
  final isInCart = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    fetchDetail(args['id']);
  }

  Future<void> fetchDetail(int id) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      product.value = await _apiService.fetchProductDetail(id);
      isInCart.value = await _cartService.isInCart(id);
    } catch (_) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleCart() async {
    final currentProduct = product.value;
    if (currentProduct == null) return;

    if (isInCart.value) {
      await _cartService.removeFromCart(currentProduct.id);
      isInCart.value = false;
    } else {
      await _cartService.addToCart(currentProduct.id);
      isInCart.value = true;
    }
  }
}
