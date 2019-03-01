package com.wrbug.gitbbs.flutterbridge.mmkv.method

import com.wrbug.gitbbs.flutterbridge.FlutterMethodCall
import com.wrbug.gitbbs.mmkv.UserKv
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class GetTokenCall : FlutterMethodCall {
    override fun invoke(call: MethodCall, result: MethodChannel.Result) {
        result.success(UserKv.getToken())
    }


    override fun getMethodName() = "getToken"
}