import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localmarket/common/storage_services.dart';
import 'package:localmarket/shopkeeper/profile/model/profile_model.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';
import 'package:localmarket/widget/validation_controller.dart';

class ProfileController extends GetxController {
  final Rxn<XFile> selectedImage = Rxn<XFile>();

  final RxString shopImageUrl = ''.obs;

  final ImagePicker _imagePicker = ImagePicker();

  final RxString ownerName = ''.obs;
  final RxString shopName = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxString address = ''.obs;

  final RxBool isLoading = true.obs;
  final RxBool isSaving = false.obs;
  final RxBool isUploadingImage = false.obs;

  final RxnDouble latitude = RxnDouble();
  final RxnDouble longitude = RxnDouble();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<String> categories = <String>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      final User? user = _auth.currentUser;

      if (user == null) {
        AppSnackbar.error('User is not logged in.');
        return;
      }

      final DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!doc.exists || doc.data() == null) {
        AppSnackbar.error('Profile information not found.');
        return;
      }

      final ProfileModel profile = ProfileModel.fromMap(doc.data()!, doc.id);

      ownerName.value = profile.ownerName;
      shopName.value = profile.shopName;
      email.value = profile.email;
      phone.value = profile.phone;
      shopImageUrl.value = profile.shopImage;
      address.value = profile.address;

      latitude.value = profile.latitude;
      longitude.value = profile.longitude;

      categories.assignAll(profile.categories);
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to load profile.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while loading profile.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    try {
      isSaving.value = true;

      final User? user = _auth.currentUser;

      if (user == null) {
        AppSnackbar.error('User is not logged in.');
        return;
      }

      if (selectedImage.value != null) {
        final String? uploadedUrl = await uploadShopImage(selectedImage.value!);

        if (uploadedUrl == null || uploadedUrl.isEmpty) {
          return;
        }

        shopImageUrl.value = uploadedUrl;
      }

      await _firestore.collection('shopkeepers').doc(user.uid).update({
        'ownerName': ownerName.value.trim(),
        'storeName': shopName.value.trim(),
        'phone': phone.value.trim(),
        'address': address.value.trim(),
        'shopImage': shopImageUrl.value.trim(),
        'categories': categories.toList(),
        'latitude': latitude.value,
        'longitude': longitude.value,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      selectedImage.value = null;

      AppSnackbar.success('Profile updated successfully.');
    } on FirebaseException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to update profile.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while updating profile.');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> pickShopImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      AppSnackbar.error('Unable to select image.');
    }
  }

  //temprory code
  Future<String?> uploadShopImage(XFile image) async {
    try {
      isUploadingImage.value = true;

      final String? imageUrl = await CloudinaryService.uploadImage(
        image: image,
        folder: 'shop_profiles',
      );

      if (imageUrl == null || imageUrl.isEmpty) {
        AppSnackbar.error('Unable to upload shop image.');
        return null;
      }

      return imageUrl;
    } catch (e) {
      AppSnackbar.error('Unable to upload shop image.');
      return null;
    } finally {
      isUploadingImage.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isSaving.value = true;

      await _auth.signOut();

      Get.offAllNamed(AppRoutes.signin);
    } on FirebaseAuthException catch (e) {
      AppSnackbar.error(e.message ?? 'Unable to logout.');
    } catch (e) {
      AppSnackbar.error('Something went wrong while logging out.');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      isSaving.value = true;

      final User? user = _auth.currentUser;

      if (user == null) {
        AppSnackbar.error('User is not logged in.');
        return false;
      }

      if (user.email == null || user.email!.isEmpty) {
        AppSnackbar.error('Password change is not available for this account.');
        return false;
      }

      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      AppSnackbar.success('Password changed successfully.');

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
          AppSnackbar.error('Current password is incorrect.');
          break;

        case 'weak-password':
          AppSnackbar.error('New password is too weak.');
          break;

        case 'requires-recent-login':
          AppSnackbar.error(
            'Please login again and try changing your password.',
          );
          break;

        default:
          AppSnackbar.error(e.message ?? 'Unable to change password.');
      }

      return false;
    } catch (e) {
      AppSnackbar.error('Something went wrong while changing password.');

      return false;
    } finally {
      isSaving.value = false;
    }
  }
}
