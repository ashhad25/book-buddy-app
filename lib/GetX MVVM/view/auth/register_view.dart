import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/custom_text_form_field.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/gradient_background_widget.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/round_button.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/route_names.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view/base_view.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/controllers/auth/register_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final registerViewModel = Get.put(RegisterViewModel());
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
            title: Text('register'.tr),
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
                              return 'Enter username';
                            }
                            return null;
                          },
                          controller:
                              registerViewModel.usernameController.value,
                          hintText: 'username_hint'.tr,
                          focusNode: registerViewModel.usernameFocusNode.value,
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                          controller: registerViewModel.emailController.value,
                          hintText: 'email_hint'.tr,
                          focusNode: registerViewModel.emailFocusNode.value,
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
                            obscureText: registerViewModel.obscureText.value,
                            obscuringCharacter: '*',
                            controller:
                                registerViewModel.passwordController.value,
                            hintText: 'password_hint'.tr,
                            focusNode:
                                registerViewModel.passwordFocusNode.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                registerViewModel.obscureText.value =
                                    !registerViewModel.obscureText.value;
                              },
                              color: AppColors.whiteColor,
                              icon:
                                  registerViewModel.obscureText.value
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
                          text: 'login_now'.tr,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(RouteNames.loginView);
                                  registerViewModel.usernameController.value
                                      .clear();
                                  registerViewModel.emailController.value
                                      .clear();
                                  registerViewModel.passwordController.value
                                      .clear();
                                },
                        ),
                      ],
                      text: '${'already_account'.tr} ',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => RoundButton(
                      loading: registerViewModel.loading.value,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerViewModel.register();
                        }
                      },
                      text: 'register'.tr,
                      width: double.infinity,
                      height: 55,
                    ),
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
