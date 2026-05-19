import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8DEF8),
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(
              'Hai, ${controller.username.value}!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1B1F),
              ),
            )),
        actions: [
          IconButton(
            onPressed: () => _showLogoutDialog(context, controller),
            icon: const Icon(Icons.logout_rounded, color: Color(0xFF6750A4)),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Info Card
            Obx(() => _buildLocationCard(controller)),
            const SizedBox(height: 20),

            // News Card
            _buildMenuCard(
              controller: controller,
              category: 'news',
              title: 'News',
              description:
                  'Get an overview of the latest SpaceFlight news, from various sources!. Easily link your users to the right websites',
              icon: Icons.newspaper_rounded,
              iconColor: const Color(0xFF6750A4),
              bgColor: const Color(0xFFE8DEF8),
            ),
            const SizedBox(height: 16),

            // Blog Card
            _buildMenuCard(
              controller: controller,
              category: 'blogs',
              title: 'Blog',
              description:
                  'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast',
              icon: Icons.article_rounded,
              iconColor: const Color(0xFF7D5260),
              bgColor: const Color(0xFFFFD8E4),
            ),
            const SizedBox(height: 16),

            // Report Card
            _buildMenuCard(
              controller: controller,
              category: 'reports',
              title: 'Report',
              description:
                  'Space stations and other missions often publish their data. With SNAPI, you can include it in your app',
              icon: Icons.assessment_rounded,
              iconColor: const Color(0xFF006C4C),
              bgColor: const Color(0xFFB5F1CC),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(HomeController controller) {
    if (controller.locationLoading.value) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: const Row(
          children: [
            SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 12),
            Text('Mengambil lokasi...'),
          ],
        ),
      );
    }

    if (controller.locationError.value.isNotEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.location_off_rounded, color: Colors.grey.shade400, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(controller.locationError.value,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ),
            GestureDetector(
              onTap: controller.loadLocation,
              child: const Icon(Icons.refresh_rounded, color: Color(0xFF6750A4), size: 20),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6750A4), Color(0xFF9A82DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6750A4).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lokasi Kamu',
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  '${controller.latitude.value.toStringAsFixed(4)}, ${controller.longitude.value.toStringAsFixed(4)}',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.loadLocation,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.refresh_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required HomeController controller,
    required String category,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return GestureDetector(
      onTap: () => controller.goToList(category),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: bgColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1C1B1F))),
                  const SizedBox(height: 6),
                  Text(description,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, HomeController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              controller.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6750A4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
