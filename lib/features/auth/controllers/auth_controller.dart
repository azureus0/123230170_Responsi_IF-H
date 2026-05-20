import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

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

  Future<void> register() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return;
    }

    if (password.length < 6) {
      return;
    }

    if (password != confirmPassword) {
      return;
    }

    isLoading.value = true;
    final success = await _authService.register(username, password);
    isLoading.value = false;

    if (success) {
      clearFields();
      Get.back();
    }
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      return;
    }

    isLoading.value = true;
    final success = await _authService.login(username, password);
    isLoading.value = false;

    if (success) {
      clearFields();
      Get.offAllNamed('/store');
    }
  }

  Future<void> checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      Get.offAllNamed('/store');
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
