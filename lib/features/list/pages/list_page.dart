import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/list_controller.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8DEF8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1C1B1F)),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              controller.getCategoryTitle(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1C1B1F),
              ),
            )),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6750A4)),
          );
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text('Gagal memuat data', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.fetchArticles,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6750A4), foregroundColor: Colors.white),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        if (controller.articles.isEmpty) {
          return Center(
            child: Text('Tidak ada data', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchArticles,
          color: const Color(0xFF6750A4),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.articles.length,
            itemBuilder: (context, index) {
              final article = controller.articles[index];
              return GestureDetector(
                onTap: () => controller.goToDetail(article.id),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          article.imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 180,
                            color: const Color(0xFFE8DEF8),
                            child: const Icon(Icons.image_not_supported, size: 50, color: Color(0xFF6750A4)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1C1B1F)),
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(article.newsSite,
                              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat('MMMM dd, yyyy').format(article.publishedAt),
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                                ),
                                const Icon(Icons.arrow_forward, size: 18, color: Color(0xFF6750A4)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
