import 'package:mintyn/core/error/error.dart';
import 'package:mintyn/core/network_info/network_info.dart';

class InternetSafeRunner {
  InternetSafeRunner(this.networkInfo);

  final NetworkInfo networkInfo;

  Future<T> call<T>({required Future<T> Function() safeCallback}) async {
    if (await networkInfo.isConnected) {
      return safeCallback();
    } else {
      throw const MintynException.noInternet();
    }
  }
}
