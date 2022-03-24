import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImplementation extends NetworkInfo {
  late Connectivity conn;

  NetworkInfoImplementation(this.conn);
  @override
  Future<bool> isConnected() async {
    ConnectivityResult result = await (conn.checkConnectivity());
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }
}
