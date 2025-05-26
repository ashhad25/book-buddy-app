import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? hintText;
  final FocusNode? focusNode;
  final String? obscuringCharacter;
  final Widget? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.validator,
    required this.controller,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.hintText,
    required this.focusNode,
    this.obscuringCharacter = '.',
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: AppColors.whiteColor),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText!,
      obscuringCharacter: obscuringCharacter!,
      focusNode: focusNode,
      style: TextStyle(color: AppColors.whiteColor),
    );
  }
}
