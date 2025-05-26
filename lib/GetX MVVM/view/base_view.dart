import 'package:book_buddy/GetX%20MVVM/data/network/network_controller.dart';
import 'package:book_buddy/GetX%20MVVM/resources/components/internet_exception_widget.dart';
import 'package:book_buddy/GetX%20MVVM/utils/utils.dart';
import 'package:book_buddy/GetX%20MVVM/view_models/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseView extends StatelessWidget {
  final Widget child;

  const BaseView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final networkController = Get.find<NetworkController>();

      // Wait until initial connection check is done
      if (!networkController.isInitialCheckDone.value) {
        return const SizedBox(); // Optionally show a loader
      }

      final showChild =
          networkController.isConnected.value &&
          networkController.hasUserRequestedRetry.value;

      final alreadyCalledLogin = false.obs;

      if (showChild && !alreadyCalledLogin.value) {
        alreadyCalledLogin.value = true;
        SplashServices().isLogin();
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeOutBack,
        transitionBuilder: (Widget widget, Animation<double> animation) {
          final fade = FadeTransition(opacity: animation, child: widget);
          final scale = ScaleTransition(scale: animation, child: fade);
          return scale;
        },
        child:
            showChild
                ? KeyedSubtree(key: const ValueKey('child'), child: child)
                : KeyedSubtree(
                  key: const ValueKey('no_internet'),
                  child: InternetExceptionWidget(
                    onPress: () => _handleRetry(networkController),
                  ),
                ),
      );
    });
  }

  void _handleRetry(NetworkController networkController) async {
    networkController.isRetrying.value = true;

    // Optional loading delay to show some feedback
    await Future.delayed(const Duration(seconds: 1));

    if (networkController.isConnected.value) {
      networkController.hasUserRequestedRetry.value = true;
      networkController.isRetrying.value = false;

      Utils.snackBar('Success', 'Reconnected to the internet');

      // 🚀 Call isLogin here after confirming connection
      SplashServices().isLogin();
    } else {
      networkController.isRetrying.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utils.snackBar('No Internet', 'Please connect to the internet first');
      });
    }
  }
}
