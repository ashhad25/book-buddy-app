import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  var isConnected = false.obs;
  var hasUserRequestedRetry = false.obs;
  var isRetrying = false.obs;
  var isInitialCheckDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();

    // Use the new Stream<List<ConnectivityResult>>
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      bool currentlyConnected = results.any(
        (r) => r != ConnectivityResult.none,
      );
      isConnected.value = currentlyConnected;

      if (!currentlyConnected) {
        hasUserRequestedRetry.value = false;
      }
    });
  }

  void _checkInitialConnection() async {
    // Also returns List<ConnectivityResult>
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    bool currentlyConnected = results.any((r) => r != ConnectivityResult.none);

    isConnected.value = currentlyConnected;

    if (currentlyConnected) {
      hasUserRequestedRetry.value = true;
    }

    isInitialCheckDone.value = true;
  }
}
