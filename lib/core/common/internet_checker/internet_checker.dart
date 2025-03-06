import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  // Function to check internet connection status
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection is available
    }
  }
}
