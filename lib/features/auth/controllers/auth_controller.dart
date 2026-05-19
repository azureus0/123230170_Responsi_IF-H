import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/services/auth_service.dart';
import '../../../core/services/notification_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final NotificationService _notificationService = NotificationService();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Register a new user
  Future<void> register() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password minimal 6 karakter!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Password tidak sama!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isLoading.value = true;
    final success = await _authService.register(username, password);
    isLoading.value = false;

    if (success) {
      Get.snackbar(
        'Berhasil!',
        'Registrasi berhasil! Silakan login.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      clearFields();
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Username sudah terdaftar!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  /// Login with credentials
  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isLoading.value = true;
    final success = await _authService.login(username, password);
    isLoading.value = false;

    if (success) {
      await _notificationService.showNotification(
        id: 0,
        title: 'Login Berhasil! 🚀',
        body: 'Selamat datang, $username!',
      );
      clearFields();
      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'Error',
        'Username atau password salah!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  /// Check if already logged in (auto login)
  Future<void> checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      Get.offAllNamed('/home');
    }
  }

  void clearFields() {
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
