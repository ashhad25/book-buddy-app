import 'dart:ui';

import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/gradient_background_widget.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:book_buddy/GetX%20MVVM/view/user/user_profile_controller.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/auth/login_view_model.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/book/book_favourite_model.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/user%20preferences/user_preferences_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final userProfileController = Get.put(UserProfileController());
  final bookFavoriteModel = Get.put(BookFavouriteModel());
  final userPreferencesViewModel = Get.put(UserPreferencesViewModel());

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('User Profile'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: GradientBackground(
          child: Obx(
            () => SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            image:
                                userProfileController.pickedImage.value != null
                                    ? DecorationImage(
                                      image: FileImage(
                                        userProfileController
                                            .pickedImage
                                            .value!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                    : null,
                          ),
                          child:
                              userProfileController.pickedImage.value == null
                                  ? InkWell(
                                    onTap:
                                        () => userProfileController.pickImage(),
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white70,
                                      size: 50,
                                    ),
                                  )
                                  : null,
                        ),
                        if (userProfileController.pickedImage.value != null)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: InkWell(
                                onTap: () => userProfileController.pickImage(),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: userProfileController.usernameController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: 'Enter Username',
                            hintStyle: TextStyle(color: Colors.white38),
                          ),
                          onSubmitted: (value) {
                            userProfileController.userName.value = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: userProfileController.emailController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white24),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white10,
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(color: Colors.white38),
                          ),
                          onSubmitted: (value) {
                            userProfileController.userEmail.value = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Obx(() {
                      final bio = userProfileController.userBio.value.trim();
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "About Me",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    userProfileController.userBio.value = '';
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.whiteColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            bio.isNotEmpty
                                ? Container(
                                  width: double.infinity,
                                  height: 80,
                                  child: Center(
                                    child: Text(
                                      bio,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                : TextField(
                                  controller:
                                      userProfileController.bioController,
                                  maxLines: 3,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText:
                                        "Write something about yourself...",
                                    hintStyle: const TextStyle(
                                      color: Colors.white38,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (value) {
                                    userProfileController.userBio.value = value;
                                  },
                                ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 10),

                    // Favorite Books Count (Stats Grid)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Obx(() {
                        return _buildStatBox(
                          "Favorites",
                          bookFavoriteModel.favCounter.toString(),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),

                    // Settings Buttons
                    Column(
                      children: [
                        Card(
                          color: AppColors.transparent,
                          child: ListTile(
                            leading: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "Change Password",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (_) => BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5.0,
                                        sigmaY: 5.0,
                                      ),
                                      child: AlertDialog(
                                        backgroundColor: AppColors.primaryColor,
                                        title: const Text(
                                          "Change Password",
                                          style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Obx(
                                          () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                obscureText:
                                                    userProfileController
                                                        .obsecureText
                                                        .value,
                                                decoration: InputDecoration(
                                                  labelText: "Current Password",
                                                  labelStyle: TextStyle(
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      userProfileController
                                                          .setObsecureText(
                                                            !userProfileController
                                                                .obsecureText
                                                                .value,
                                                          );
                                                    },
                                                    icon:
                                                        userProfileController
                                                                .obsecureText
                                                                .value
                                                            ? Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              color:
                                                                  AppColors
                                                                      .whiteColor,
                                                            )
                                                            : Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  AppColors
                                                                      .whiteColor,
                                                            ),
                                                  ),
                                                ),
                                                obscuringCharacter: '*',
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                ),
                                                controller:
                                                    userProfileController
                                                        .oldPasswordController,
                                              ),
                                              TextField(
                                                obscureText:
                                                    userProfileController
                                                        .obsecureText2
                                                        .value,
                                                decoration: InputDecoration(
                                                  labelText: "New Password",
                                                  labelStyle: TextStyle(
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      userProfileController
                                                          .setObsecureText2(
                                                            !userProfileController
                                                                .obsecureText2
                                                                .value,
                                                          );
                                                    },
                                                    icon:
                                                        userProfileController
                                                                .obsecureText2
                                                                .value
                                                            ? Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              color:
                                                                  AppColors
                                                                      .whiteColor,
                                                            )
                                                            : Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  AppColors
                                                                      .whiteColor,
                                                            ),
                                                  ),
                                                ),
                                                obscuringCharacter: '*',
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                ),
                                                controller:
                                                    userProfileController
                                                        .newPasswordController,
                                              ),
                                              TextField(
                                                obscureText:
                                                    userProfileController
                                                        .obsecureText3
                                                        .value,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "Confirm New Password",
                                                  labelStyle: TextStyle(
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      userProfileController
                                                          .setObsecureText3(
                                                            !userProfileController
                                                                .obsecureText3
                                                                .value,
                                                          );
                                                    },
                                                    icon:
                                                        userProfileController
                                                                .obsecureText3
                                                                .value
                                                            ? Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              color:
                                                                  AppColors
                                                                      .whiteColor,
                                                            )
                                                            : Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  AppColors
                                                                      .whiteColor,
                                                            ),
                                                  ),
                                                ),
                                                obscuringCharacter: '*',
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                ),
                                                controller:
                                                    userProfileController
                                                        .confirmPasswordController,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              userProfileController
                                                  .oldPasswordController
                                                  .clear();
                                              userProfileController
                                                  .newPasswordController
                                                  .clear();
                                              userProfileController
                                                  .confirmPasswordController
                                                  .clear();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: const Text(
                                              "Update",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              userProfileController
                                                  .updatePassword();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              elevation: 6,
                                              shadowColor: AppColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              );
                            },
                          ),
                        ),
                        Card(
                          color: AppColors.transparent,
                          child: ListTile(
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Utils.showDialog(
                                'Log Out',
                                'Are you sure you want to log out?',
                                context,
                                () {
                                  userPreferencesViewModel.logOutUser().then((
                                    value,
                                  ) {
                                    Get.delete<LoginViewModel>();
                                    Get.toNamed(RouteNames.loginView);
                                    Utils.snackBar(
                                      'Success',
                                      'Logged Out Successfully',
                                    );
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Edit Profile Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            userProfileController.saveUserProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 30,
                              top: 15,
                              bottom: 15,
                            ),
                          ),
                          icon: const Icon(
                            Icons.save,
                            color: AppColors.whiteColor,
                          ),
                          label: const Text(
                            "Save Profile",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            Utils.showDialog(
                              'Delete Account',
                              'Are you sure you want to delete your account?',
                              context,
                              () {
                                userProfileController.deleteAccount();
                              },
                              icon: Icons.delete_forever,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 15,
                              bottom: 15,
                            ),
                          ),
                          icon: const Icon(
                            Icons.delete_forever,
                            color: AppColors.whiteColor,
                          ),
                          label: const Text(
                            "Delete Account",
                            style: TextStyle(color: AppColors.whiteColor),
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
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
