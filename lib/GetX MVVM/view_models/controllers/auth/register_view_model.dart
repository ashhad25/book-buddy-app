import 'package:book_buddy/GetX%20MVVM/models/login/user_model.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/user%20preferences/user_preferences_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterViewModel extends GetxController {
  UserPreferencesViewModel _userPreferencesViewModel =
      UserPreferencesViewModel();
  final emailController = TextEditingController().obs;
  final usernameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxBool obscureText = true.obs;

  final emailFocusNode = FocusNode().obs;
  final usernameFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  @override
  void dispose() {
    emailController.value.dispose();
    usernameController.value.dispose();
    passwordController.value.dispose();
    emailFocusNode.value.dispose();
    usernameFocusNode.value.dispose();
    passwordFocusNode.value.dispose();
    super.dispose();
  }

  RxBool loading = false.obs;

  void register() {
    loading.value = true;

    _userPreferencesViewModel
        .getUser()
        .then((value) async {
          if (value.email == emailController.value.text) {
            Utils.snackBar('Error', 'user already exists!');
          } else {
            UserModel userModel = UserModel(
              email: emailController.value.text,
              username: usernameController.value.text,
              password: passwordController.value.text,
            );

            await Future.delayed(const Duration(seconds: 2));
            _userPreferencesViewModel
                .saveUser(userModel)
                .then((value) {
                  loading.value =
                      false; // Optional loading delay to show some feedback
                  Get.toNamed(RouteNames.loginView)!;
                  emailController.value.clear();
                  usernameController.value.clear();
                  passwordController.value.clear();
                  if (kDebugMode) {
                    print(userModel.email);
                    print(userModel.username);
                    print(userModel.password);
                  }
                  Utils.snackBar('Succesfull', 'User Registered Succesfully');
                })
                .onError((error, stackTrace) {
                  loading.value = false;
                  Utils.snackBar('Error', error.toString());
                });
          }
        })
        .onError((error, stackTrace) {
          loading.value = false;
          Utils.snackBar('Error', error.toString());
        });
  }
}
