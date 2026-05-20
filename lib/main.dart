import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/register_page.dart';
import 'features/store/pages/store_page.dart';
import 'features/cart/pages/cart_page.dart';
import 'features/detail/pages/detail_page.dart';
import 'features/profile/pages/profile_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyToko',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.light,
        // scaffoldBackgroundColor: Colors.deepPurple.shade50,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/store', page: () => const StorePage()),
        GetPage(name: '/cart', page: () => const CartPage()),
        GetPage(name: '/detail', page: () => const DetailPage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
      ],
    );
  }
}
