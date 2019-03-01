package com.wrbug.gitbbs.flutterbridge.mmkv.method

import com.wrbug.gitbbs.flutterbridge.FlutterMethodCall
import com.wrbug.gitbbs.mmkv.UserKv
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class SaveTokenCall : FlutterMethodCall {
    override fun getMethodName() = "saveToken"

    override fun invoke(call: MethodCall, result: MethodChannel.Result) {
        if (call.hasArgument("token")) {
            UserKv.saveToken(call.argument<String>("token") ?: "")
            result.success(null)
            return
        }
        result.error("miss token", "", "")
    }
}