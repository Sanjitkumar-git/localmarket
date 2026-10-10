import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:localmarket/shopkeeper/profile/controller/profile_controller.dart';
import 'package:localmarket/shopkeeper/profile/widget/change_password_dialog_widget.dart';
import 'package:localmarket/shopkeeper/profile/widget/edit_profile_dialog_widget.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/common_app_bar.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  static const Color _green = Color(0xFF1B7F3B);
  static const Color _darkGreen = Color(0xFF0F5A28);
  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(
        title: 'Profile',
        showBackButton: true,
        showBranding: false,
        showSupportButton: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.refreshProfile,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth >= _wideBreakpoint;

              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          isWide ? 24 : 16,
                          16,
                          isWide ? 24 : 16,
                          30,
                        ),
                        child: isWide ? _wideLayout() : _narrowLayout(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  // ───────────────────────── LAYOUTS ─────────────────────────

  Widget _narrowLayout() {
    return Column(
      children: [
        _buildProfileHeader(),
        const SizedBox(height: 16),
        _buildPersonalInformation(),
        const SizedBox(height: 16),
        _buildShopInformation(),
        const SizedBox(height: 16),
        _buildCategories(),
        const SizedBox(height: 16),
        _buildAccountSection(),
        const SizedBox(height: 20),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _wideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 16),
              _buildAccountSection(),
              const SizedBox(height: 20),
              _buildLogoutButton(),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              _buildPersonalInformation(),
              const SizedBox(height: 16),
              _buildShopInformation(),
              const SizedBox(height: 16),
              _buildCategories(),
            ],
          ),
        ),
      ],
    );
  }

  // ───────────────────────── HEADER ─────────────────────────

  Widget _buildProfileHeader() {
    final String owner = controller.ownerName.value.isEmpty
        ? 'Owner Name'
        : controller.ownerName.value;

    final String shop = controller.shopName.value.isEmpty
        ? 'Shop Name'
        : controller.shopName.value;

    return Container(
      width: double.infinity,
      height: 185,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [_green, _darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _green.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(right: -30, top: -30, child: _circle(100, 0.08)),
          Positioned(left: -28, bottom: -32, child: _circle(80, 0.06)),
          Positioned(right: 45, bottom: 25, child: _circle(38, 0.05)),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      height: 72,
                      width: 72,
                      child: _buildProfileImage(),
                    ),
                    GestureDetector(
                      onTap: _showImagePickerOptions,
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: _green,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  owner,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTextSizes.h5,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Container(
                  constraints: const BoxConstraints(maxWidth: 210),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          shop,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppTextSizes.caption,
                            fontWeight: AppFontWeights.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, double alpha) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }

  // ───────────────────────── AVATAR ─────────────────────────

  Widget _buildProfileImage() {
    // Apna Obx, taaki image/loader ka state change hote hi sirf ye rebuild ho
    return Obx(() {
      final bytes = controller.previewBytes.value;
      final bool uploading = controller.isUploadingImage.value;
      final String url = controller.shopImageUrl.value;

      Widget content;

      if (bytes != null) {
        // Naya chuna hua image + upload ke dauran loader overlay
        content = Stack(
          fit: StackFit.expand,
          children: [
            Image.memory(bytes, fit: BoxFit.cover),
            if (uploading)
              Container(
                color: Colors.black.withValues(alpha: 0.45),
                child: const Center(
                  child: SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      } else if (url.isNotEmpty) {
        // Network image: jab tak load na ho, loader dikhega
        content = Image.network(
          url,
          key: ValueKey(url),
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;

            final total = progress.expectedTotalBytes;

            return Center(
              child: SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                  value: total != null
                      ? progress.cumulativeBytesLoaded / total
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (_, __, ___) => _storeIcon(),
        );
      } else {
        content = _storeIcon();
      }

      return _imageContainer(content);
    });
  }

  Widget _storeIcon() {
    return const Center(
      child: Icon(Icons.store_rounded, size: 46, color: _green),
    );
  }

  Widget _imageContainer(Widget child) {
    return Container(
      height: 112,
      width: 112,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Container(color: const Color(0xFFE6F5EA), child: child),
      ),
    );
  }

  // ───────────────────────── INFO SECTIONS ─────────────────────────

  Widget _buildPersonalInformation() {
    return _sectionCard(
      title: 'Personal Information',
      icon: Icons.person_outline_rounded,
      children: [
        _infoTile(
          icon: Icons.person_outline_rounded,
          title: 'Name',
          value: _orNA(controller.ownerName.value),
        ),
        _divider(),
        _infoTile(
          icon: Icons.email_outlined,
          title: 'Email',
          value: _orNA(controller.email.value),
        ),
        _divider(),
        _infoTile(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: _orNA(controller.phone.value),
        ),
      ],
    );
  }

  Widget _buildShopInformation() {
    return _sectionCard(
      title: 'Shop Information',
      icon: Icons.storefront_outlined,
      children: [
        _infoTile(
          icon: Icons.store_outlined,
          title: 'Shop Name',
          value: _orNA(controller.shopName.value),
        ),
        _divider(),
        _infoTile(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: _orNA(controller.address.value),
        ),
        if (controller.latitude.value != null &&
            controller.longitude.value != null) ...[
          _divider(),
          _infoTile(
            icon: Icons.my_location_outlined,
            title: 'Coordinates',
            value:
                '${controller.latitude.value!.toStringAsFixed(6)}, '
                '${controller.longitude.value!.toStringAsFixed(6)}',
          ),
        ],
      ],
    );
  }

  Widget _buildCategories() {
    return _sectionCard(
      title: 'Categories',
      icon: Icons.category_outlined,
      children: [
        if (controller.categories.isEmpty)
          Text(
            'No categories available.',
            style: TextStyle(
              fontSize: AppTextSizes.caption,
              color: AppColors.textSecondary,
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.categories.map((category) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: AppTextSizes.caption,
                        fontWeight: AppFontWeights.medium,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  // ───────────────────────── ACCOUNT ─────────────────────────

  Widget _buildAccountSection() {
    return _sectionCard(
      title: 'Account',
      icon: Icons.manage_accounts_outlined,
      children: [
        _actionTile(
          icon: Icons.edit_outlined,
          title: 'Edit Profile',
          subtitle: 'Update your personal and shop information',
          onTap: () {
            Get.dialog(const EditProfileDialog());
          },
        ),
        const SizedBox(height: 10),
        _actionTile(
          icon: Icons.lock_outline_rounded,
          title: 'Change Password',
          subtitle: 'Update your account password',
          onTap: () {
            Get.dialog(const ChangePasswordDialog());
          },
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Obx(() {
      final bool busy = controller.isSaving.value;

      return SizedBox(
        height: 54,
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: busy ? null : _showLogoutConfirmation,
          icon: busy
              ? SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.error,
                  ),
                )
              : const Icon(Icons.logout_rounded),
          label: Text(
            busy ? 'Logging out...' : 'Logout',
            style: TextStyle(
              fontSize: AppTextSizes.button,
              fontWeight: AppFontWeights.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.error,
            backgroundColor: AppColors.error.withValues(alpha: 0.06),
            side: BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      );
    });
  }

  // ───────────────────────── HELPERS ─────────────────────────

  String _orNA(String value) => value.isEmpty ? 'Not available' : value;

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: AppTextSizes.h6,
                    fontWeight: AppFontWeights.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppTextSizes.caption,
                  fontWeight: AppFontWeights.medium,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: AppTextSizes.button,
                  fontWeight: AppFontWeights.semiBold,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.primary.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, size: 21, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppTextSizes.button,
                        fontWeight: AppFontWeights.semiBold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: AppTextSizes.caption,
                        color: AppColors.textSecondary,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: Colors.black.withValues(alpha: 0.07)),
    );
  }

  // ───────────────────────── IMAGE PICKER SHEET ─────────────────────────

  void _showImagePickerOptions() {
    Get.bottomSheet(
      Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 24,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 4,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Change Shop Image',
                    style: TextStyle(
                      fontSize: AppTextSizes.h5,
                      fontWeight: AppFontWeights.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose where to pick the image from',
                    style: TextStyle(
                      fontSize: AppTextSizes.caption,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _imageSourceButton(
                          icon: Icons.camera_alt_outlined,
                          title: 'Camera',
                          onTap: () {
                            Get.back();
                            controller.pickShopImage(ImageSource.camera);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _imageSourceButton(
                          icon: Icons.photo_library_outlined,
                          title: 'Gallery',
                          onTap: () {
                            Get.back();
                            controller.pickShopImage(ImageSource.gallery);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageSourceButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.primary.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.18),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [_green, _darkGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(icon, size: 26, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppTextSizes.button,
                  fontWeight: AppFontWeights.semiBold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────── LOGOUT DIALOG ─────────────────────────

  void _showLogoutConfirmation() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Container(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.error.withValues(alpha: 0.10),
                    ),
                    child: Center(
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.error,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.error.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: AppTextSizes.h5,
                      fontWeight: AppFontWeights.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Are you sure you want to logout?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppTextSizes.button,
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: Get.back,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            controller.logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
