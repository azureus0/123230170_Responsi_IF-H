import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class CartService {
  static const String _keyCartProductIdsPrefix = 'cartProductIds_';
  final AuthService _authService = AuthService();

  Future<String> _getCartKey() async {
    final username = await _authService.getUsername();
    return '$_keyCartProductIdsPrefix$username';
  }

  Future<List<int>> getCartProductIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(await _getCartKey()) ?? [];
    return ids.map(int.tryParse).whereType<int>().toList();
  }

  Future<bool> isInCart(int productId) async {
    final ids = await getCartProductIds();
    return ids.contains(productId);
  }

  Future<void> addToCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cartKey = await _getCartKey();
    final ids = await getCartProductIds();
    if (!ids.contains(productId)) {
      ids.add(productId);
      await prefs.setStringList(
        cartKey,
        ids.map((id) => id.toString()).toList(),
      );
    }
  }

  Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cartKey = await _getCartKey();
    final ids = await getCartProductIds();
    ids.remove(productId);
    await prefs.setStringList(
      cartKey,
      ids.map((id) => id.toString()).toList(),
    );
  }
}
