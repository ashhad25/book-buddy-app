import 'dart:async';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/user%20preferences/user_preferences_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashServices {
  final UserPreferencesViewModel _userPreferencesViewModel =
      UserPreferencesViewModel();

  void isLogin() {
    _userPreferencesViewModel.getUser().then((value) {
      if (kDebugMode) {
        print('User isLogin: ${value.isLogin}');
      }

      Timer(const Duration(seconds: 5), () {
        // Check if still on splash before redirecting
        if (Get.currentRoute == RouteNames.splash) {
          if (value.isLogin == false || value.isLogin.toString() == 'null') {
            Get.offNamed(RouteNames.loginView);
          } else {
            Get.offNamed(RouteNames.homeView);
          }
        } else {
          if (kDebugMode) {
            print(
              'Skipping redirection because current route is ${Get.currentRoute}',
            );
          }
        }
      });
    });
  }
}
