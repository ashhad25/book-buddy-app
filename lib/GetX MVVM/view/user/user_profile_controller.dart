import 'dart:io';

import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/user%20preferences/user_preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  final _userPreferencesViewModel = UserPreferencesViewModel();

  final userName = ''.obs;
  final userEmail = ''.obs;
  final pickedImage = Rx<File?>(null);
  final userBio = ''.obs;
  final bioController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  static const _bioKey = 'user_bio';
  static const _imagePathKey = 'user_image_path';

  RxBool obsecureText = true.obs;
  RxBool obsecureText2 = true.obs;
  RxBool obsecureText3 = true.obs;
  void setObsecureText(bool _value) => obsecureText.value = _value;
  void setObsecureText2(bool _value) => obsecureText2.value = _value;
  void setObsecureText3(bool _value) => obsecureText3.value = _value;

  @override
  void onInit() async {
    super.onInit();
    await loadUserProfileData();
    await getUserProfile();
    usernameController.text = userName.value;
    emailController.text = userEmail.value;
  }

  Future<void> saveUserProfile() async {
    final updatedName = usernameController.text.trim();
    final updatedEmail = emailController.text.trim();
    final bio = bioController.text.trim();

    // Add your logic to update in backend or local storage
    userName.value = updatedName;
    userEmail.value = updatedEmail;
    userBio.value = bio;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bioKey, userBio.value);
    await prefs.setString('email', updatedEmail);
    await prefs.setString('username', updatedName);

    if (pickedImage.value != null) {
      await prefs.setString(_imagePathKey, pickedImage.value!.path);
    }

    Utils.snackBar('Success', 'Profile updated successfully');
  }

  Future<void> updatePassword() async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    final prefs = await SharedPreferences.getInstance();

    if (oldPass != prefs.getString('password')) {
      Utils.snackBar('Error', 'Old password is incorrect');
    } else {
      if (newPass != confirmPass) {
        Utils.snackBar('Error', 'New passwords do not match');
        return;
      } else {
        await prefs
            .setString('password', newPass)
            .then((value) {
              Utils.snackBar('Success', 'Password updated successfully');
            })
            .onError((error, stackTrace) {
              Utils.snackBar('Error', 'Failed to update password');
            });
      }
    }
  }

  Future<void> loadUserProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    userBio.value = prefs.getString(_bioKey) ?? '';
    bioController.text = userBio.value;

    final imagePath = prefs.getString(_imagePathKey);
    if (imagePath != null && File(imagePath).existsSync()) {
      pickedImage.value = File(imagePath);
    }
  }

  Future<void> getUserProfile() async {
    await _userPreferencesViewModel.getUser().then((value) {
      userName.value = value.username.toString();
      userEmail.value = value.email.toString();
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .clear()
        .then((value) {
          Utils.snackBar('Success', 'Account deleted successfully');
          Get.toNamed(RouteNames.registerView);
        })
        .onError((error, stackTrace) {
          Utils.snackBar('Error', 'Failed to delete account');
        });
  }
}
