import 'package:get/get.dart';
import '../../../shared/services/auth_service.dart';
import '../../../core/services/location_service.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService();
  final LocationService _locationService = LocationService();

  final username = ''.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final locationLoading = false.obs;
  final locationError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsername();
    loadLocation();
  }

  /// Load the logged-in username from SharedPreferences
  Future<void> loadUsername() async {
    username.value = await _authService.getUsername();
  }

  /// Get device location
  Future<void> loadLocation() async {
    locationLoading.value = true;
    locationError.value = '';
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      } else {
        locationError.value = 'Lokasi tidak tersedia';
      }
    } catch (e) {
      locationError.value = 'Gagal mengambil lokasi';
    }
    locationLoading.value = false;
  }

  /// Logout and navigate to login page
  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }

  /// Navigate to list page with category
  void goToList(String category) {
    Get.toNamed('/list', arguments: category);
  }
}
