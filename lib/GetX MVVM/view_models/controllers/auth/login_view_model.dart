import 'package:book_buddy/GetX%20MVVM/models/login/user_model.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/user%20preferences/user_preferences_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  // final _api = LoginRepository();
  UserPreferencesViewModel _userPreferencesViewModel =
      UserPreferencesViewModel();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxBool obscureText = true.obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void login() {
    loading.value = true;

    _userPreferencesViewModel
        .getUser()
        .then((value) async {
          if (kDebugMode) {
            print(value.email);
            print(value.username);
            print(value.password);
          }
          if (value.email == emailController.value.text &&
              value.password == passwordController.value.text) {
            UserModel userModel = UserModel(
              isLogin: true,
              email: value.email,
              password: value.password,
              username: value.username,
            );

            await Future.delayed(const Duration(seconds: 2));
            _userPreferencesViewModel
                .saveUser(userModel)
                .then((value) async {
                  loading.value = false;
                  Get.toNamed(RouteNames.homeView)!;
                  emailController.value.clear();
                  passwordController.value.clear();
                  Utils.snackBar('Succesfull', 'User Logged In Succesfully');
                })
                .onError((error, stackTrace) {
                  loading.value = false;
                  Utils.snackBar('Error', error.toString());
                });
          } else {
            loading.value = false;
            Utils.snackBar('Error', 'user does not exist!');
          }
        })
        .onError((error, stackTrace) {
          loading.value = false;
          Utils.snackBar('Error', error.toString());
        });
  }
}
