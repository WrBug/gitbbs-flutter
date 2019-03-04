package com.wrbug.gitbbs.flutterbridge.mmkv.method

import com.wrbug.gitbbs.flutterbridge.FlutterMethodCall
import com.wrbug.gitbbs.mmkv.UserKv
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class SaveUserCall : FlutterMethodCall {
    override fun getMethodName() = "saveUser"

    override fun invoke(call: MethodCall, result: MethodChannel.Result) {
        if (call.hasArgument("user")) {
            val user = call.argument<String>("user") ?: ""
            UserKv.saveUser(user)
            result.success(null)
            return
        }
        result.error("miss user", "", "")
    }
}