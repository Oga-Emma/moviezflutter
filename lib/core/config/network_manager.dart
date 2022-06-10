import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  final Connectivity _connectivity;
  NetworkManager(Connectivity connectivity) : _connectivity = connectivity;

  Future<bool> hasNetwork() async {
    try {
      final netInfo = await _connectivity.checkConnectivity();
      return !(netInfo == ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }
}
