import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/detail_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8DEF8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1C1B1F)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'News Detail',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1B1F),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6750A4)),
          );
        }

        if (controller.hasError.value || controller.article.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'Gagal memuat detail',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ],
            ),
          );
        }

        final article = controller.article.value!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image
              Image.network(
                article.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: const Color(0xFFE8DEF8),
                  child: const Icon(Icons.image_not_supported,
                      size: 60, color: Color(0xFF6750A4)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C1B1F),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // News Site
                    Text(
                      article.newsSite,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Published Date
                    Text(
                      DateFormat('MMMM dd, yyyy').format(article.publishedAt),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 16),

                    // Summary / Content
                    Text(
                      article.summary,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1C1B1F),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isLoading.value || controller.article.value == null) {
          return const SizedBox();
        }
        return FloatingActionButton.extended(
          onPressed: controller.openUrl,
          backgroundColor: const Color(0xFF6750A4),
          foregroundColor: Colors.white,
          icon: const Icon(Icons.open_in_browser_rounded),
          label: const Text(
            'See more...',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      }),
    );
  }
}
