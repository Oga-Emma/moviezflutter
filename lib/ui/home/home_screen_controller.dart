import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/core/config/network_manager.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get it {
    if (Get.isRegistered<HomeScreenController>()) {
      return Get.find();
    }
    return Get.put(HomeScreenController(
        connectivityManager: Get.find(), networkManager: Get.find()));
  }

  HomeScreenController(
      {required this.connectivityManager, required this.networkManager});
  final Connectivity connectivityManager;
  final NetworkManager networkManager;
  StreamSubscription<ConnectivityResult>? subscription;

  final connection = NetworkConnectionState.connected.obs;

  @override
  void onReady() {
    subscription = connectivityManager.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if ((await networkManager.hasNetwork())) {
        connection.value = NetworkConnectionState.connected;
      } else {
        connection.value = NetworkConnectionState.not_connected;
      }
    });
    super.onReady();
  }

  final selectedPage = 0.obs;
  void changePage(int value) {
    if (value != selectedPage.value) {
      selectedPage.value = value;
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}

enum NetworkConnectionState { connected, not_connected }
