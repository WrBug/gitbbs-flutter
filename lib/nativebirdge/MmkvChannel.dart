import 'package:flutter/services.dart';
import 'package:gitbbs/constant/NativeBridgeConstant.dart';

class MmkvChannel {
  static const platform = const MethodChannel('$CHANNEL_PREFIX/$CHANNEL_MMKV');
  static MmkvChannel instance = MmkvChannel();

  static MmkvChannel getInstance() {
    return instance;
  }

  Future<String> getToken() async {
    try {
      String result = await platform.invokeMethod('getToken');
      return result;
    } on PlatformException catch (e) {
      return Future.value("");
    }
  }

  Future saveToken(String token) async {
    try {
      String result =
          await platform.invokeMethod('saveToken', {'token': token});
      return result;
    } on PlatformException catch (e) {
      return Future.value();
    }
  }
}
