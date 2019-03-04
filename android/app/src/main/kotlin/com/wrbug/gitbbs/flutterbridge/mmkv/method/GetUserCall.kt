package com.wrbug.gitbbs.flutterbridge.mmkv.method

import com.wrbug.gitbbs.flutterbridge.FlutterMethodCall
import com.wrbug.gitbbs.mmkv.UserKv
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class GetUserCall : FlutterMethodCall {
    override fun invoke(call: MethodCall, result: MethodChannel.Result) {
        result.success(UserKv.getUser())
    }


    override fun getMethodName() = "getUser"
}