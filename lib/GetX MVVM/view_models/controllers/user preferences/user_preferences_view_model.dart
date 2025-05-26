import 'package:book_buddy/GetX%20MVVM/models/login/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesViewModel extends GetxController {
  Future<bool> saveUser(UserModel responseModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', responseModel.isLogin ?? false);
    await prefs.setString('email', responseModel.email.toString());
    await prefs.setString('username', responseModel.username.toString());
    await prefs.setString('password', responseModel.password.toString());
    return true;
  }

  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    String? email = prefs.getString('email');
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    return UserModel(
      isLogin: isLogin,
      email: email,
      password: password,
      username: username,
    );
  }

  Future<bool> logOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);
    return true;
  }
}
