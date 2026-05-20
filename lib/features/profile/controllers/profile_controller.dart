import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/services/auth_service.dart';

class ProfileController extends GetxController {
  static const String _keyProfilePhotoPathPrefix = 'profilePhotoPath_';

  final AuthService _authService = AuthService();
  final ImagePicker _imagePicker = ImagePicker();

  final username = ''.obs;
  final profilePhotoPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  String get _profilePhotoKey => '$_keyProfilePhotoPathPrefix${username.value}';

  Future<void> loadProfile() async {
    username.value = await _authService.getUsername();
    await loadProfilePhoto();
  }

  Future<void> loadProfilePhoto() async {
    final prefs = await SharedPreferences.getInstance();
    profilePhotoPath.value = prefs.getString(_profilePhotoKey) ?? '';
  }

  Future<void> pickProfilePhoto(ImageSource source) async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedImage == null) return;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_profilePhotoKey, pickedImage.path);
      profilePhotoPath.value = pickedImage.path;
      if (Get.isBottomSheetOpen ?? false) Get.back();
    } catch (e) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }
}
