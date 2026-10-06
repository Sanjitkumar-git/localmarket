import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/profile/controller/profile_controller.dart';

import 'package:localmarket/shopkeeper/profile/widget/premium_dialog_shell.dart';
import 'package:localmarket/widget/validation_controller.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final ProfileController controller;

  late final TextEditingController ownerNameController;
  late final TextEditingController shopNameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    controller = Get.find<ProfileController>();

    ownerNameController = TextEditingController(
      text: controller.ownerName.value,
    );
    shopNameController = TextEditingController(text: controller.shopName.value);
    phoneController = TextEditingController(text: controller.phone.value);
    addressController = TextEditingController(text: controller.address.value);
  }

  @override
  void dispose() {
    ownerNameController.dispose();
    shopNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _close() => Navigator.of(context).pop();

  void _save() {
    final String owner = ownerNameController.text.trim();
    final String shop = shopNameController.text.trim();
    final String phone = phoneController.text.trim();
    final String address = addressController.text.trim();

    if (owner.isEmpty) {
      AppSnackbar.error('Please enter your name.');
      return;
    }

    if (shop.isEmpty) {
      AppSnackbar.error('Please enter your shop name.');
      return;
    }

    if (phone.isEmpty) {
      AppSnackbar.error('Please enter your phone number.');
      return;
    }

    controller.ownerName.value = owner;
    controller.shopName.value = shop;
    controller.phone.value = phone;
    controller.address.value = address;

    // Dialog turant band, save background mein chalega
    _close();
    controller.updateProfile();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumDialogShell(
      title: 'Edit Profile',
      subtitle: 'Update your personal and shop information',
      icon: Icons.edit_outlined,
      onClose: _close,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: ownerNameController,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: premiumInputDecoration(
              label: 'Name',
              icon: Icons.person_outline_rounded,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: shopNameController,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: premiumInputDecoration(
              label: 'Shop Name',
              icon: Icons.store_outlined,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: premiumInputDecoration(
              label: 'Phone Number',
              icon: Icons.phone_outlined,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: addressController,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: premiumInputDecoration(
              label: 'Address',
              icon: Icons.location_on_outlined,
            ),
          ),
          const SizedBox(height: 22),
          Obx(
            () => PremiumDialogButton(
              label: 'Save Changes',
              icon: Icons.check_rounded,
              loading: controller.isSaving.value,
              onPressed: controller.isSaving.value ? null : _save,
            ),
          ),
        ],
      ),
    );
  }
}
