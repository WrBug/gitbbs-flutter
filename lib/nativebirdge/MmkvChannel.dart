import 'package:flutter/services.dart';
import 'package:gitbbs/constant/NativeBridgeConstant.dart';
import 'package:gitbbs/model/GitUser.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import 'dart:convert';

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
    } on PlatformException {
      return Future.value("");
    }
  }

  Future saveToken(String token) async {
    try {
      String result =
          await platform.invokeMethod('saveToken', {'token': token});
      return result;
    } on PlatformException {
      return Future.value();
    }
  }

  Future<GitUser> getUser() async {
    try {
      String json = await platform.invokeMethod('getUser');
      if (json == null || json == '') {
        return Future.value(null);
      }
      return GithubV4User.fromJson(jsonDecode(json));
    } on PlatformException catch (e) {
      return Future.value(null);
    }
  }

   saveUser(GitUser user) async {
    try {
     await platform
          .invokeMethod('saveUser', {'user': user?.toJsonString()});
    } on PlatformException {
    }
  }
}
