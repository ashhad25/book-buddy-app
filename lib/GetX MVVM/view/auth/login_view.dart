import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/custom_text_form_field.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/gradient_background_widget.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/round_button.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/auth/login_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginViewModel = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Utils.showDialog(
            "Exit App",
            "Are you sure you want to exit the app?",
            context,
            () => SystemNavigator.pop(), // or exit(0)
          );
        }
      },
      child: BaseView(
        child: Scaffold(
          appBar: AppBar(
            title: Text('login'.tr),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          resizeToAvoidBottomInset: false,
          body: GradientBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                          controller: loginViewModel.emailController.value,
                          hintText: 'email_hint'.tr,
                          focusNode: loginViewModel.emailFocusNode.value,
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                            obscureText: loginViewModel.obscureText.value,
                            obscuringCharacter: '*',
                            controller: loginViewModel.passwordController.value,
                            hintText: 'password_hint'.tr,
                            focusNode: loginViewModel.passwordFocusNode.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginViewModel.obscureText.value =
                                    !loginViewModel.obscureText.value;
                              },
                              color: AppColors.whiteColor,
                              icon:
                                  loginViewModel.obscureText.value
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'register_now'.tr,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(RouteNames.registerView);

                                  loginViewModel.emailController.value.clear();
                                  loginViewModel.passwordController.value
                                      .clear();
                                },
                        ),
                      ],
                      text: '${'no_account'.tr} ',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return RoundButton(
                      loading: loginViewModel.loading.value,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginViewModel.login();
                        }
                      },
                      text: 'login'.tr,
                      width: double.infinity,
                      height: 55,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
