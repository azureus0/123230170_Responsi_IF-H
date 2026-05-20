import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/widgets/bottom_nav_bar.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade50,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 16,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                backgroundImage: controller.profilePhotoPath.value.isEmpty
                    ? null
                    : FileImage(File(controller.profilePhotoPath.value)),
                child: controller.profilePhotoPath.value.isEmpty
                    ? const Icon(
                        Icons.person_rounded,
                        size: 58,
                        color: Colors.deepPurple,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () => _showPhotoPicker(context, controller),
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(Icons.edit, size: 14),
              label: const Text(
                'Ganti Foto',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const _ProfileInfoTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Nama',
                    value: 'Adi Dwi Pambudi',
                  ),
                  Divider(height: 1, indent: 48, color: Colors.grey.shade300),
                  const _ProfileInfoTile(
                    icon: Icons.badge_outlined,
                    title: 'NIM',
                    value: '123230170',
                  ),
                  Divider(height: 1, indent: 48, color: Colors.grey.shade300),
                  Obx(
                    () => _ProfileInfoTile(
                      icon: Icons.alternate_email_rounded,
                      title: 'Username',
                      value: controller.username.value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: controller.logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.logout_rounded, size: 17),
                label: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  void _showPhotoPicker(
    BuildContext context,
    ProfileController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.black87),
                  title: const Text('Gallery'),
                  onTap: () => controller.pickProfilePhoto(ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.black87),
                  title: const Text('Camera'),
                  onTap: () => controller.pickProfilePhoto(ImageSource.camera),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  const _ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
