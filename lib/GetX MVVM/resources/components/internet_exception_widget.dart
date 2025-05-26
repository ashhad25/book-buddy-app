import 'package:book_buddy/GetX%20MVVM/data/network/network_controller.dart';
import 'package:book_buddy/GetX%20MVVM/resources/colors/app_colors.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/gradient_background_widget.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetExceptionWidget extends StatelessWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NetworkController>();
    return GradientBackground(
      child: Center(
        child: Container(
          width: 300,
          height: 400,

          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off, color: AppColors.whiteColor, size: 100),
              const SizedBox(height: 40),
              Text(
                'No Internet Connection\n Please Try Again!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 50),
              Obx(
                () => RoundButton(
                  onPressed: controller.isRetrying.value ? () {} : onPress,
                  loading: controller.isRetrying.value,
                  color: AppColors.whiteColor,
                  loadingColor: AppColors.primaryColor,
                  textColor: AppColors.primaryColor,
                  text: 'Retry',
                  height: 55,
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
