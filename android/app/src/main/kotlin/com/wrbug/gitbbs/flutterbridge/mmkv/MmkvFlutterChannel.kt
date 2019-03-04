package com.wrbug.gitbbs.flutterbridge.mmkv

import com.wrbug.gitbbs.flutterbridge.FlutterChannel
import com.wrbug.gitbbs.flutterbridge.FlutterMethodCall
import com.wrbug.gitbbs.flutterbridge.mmkv.method.GetTokenCall
import com.wrbug.gitbbs.flutterbridge.mmkv.method.GetUserCall
import com.wrbug.gitbbs.flutterbridge.mmkv.method.SaveTokenCall
import com.wrbug.gitbbs.flutterbridge.mmkv.method.SaveUserCall
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap

class MmkvFlutterChannel : FlutterChannel() {
    val calls: Map<String, FlutterMethodCall> by lazy {
        val map = HashMap<String, FlutterMethodCall>()
        var call: FlutterMethodCall = GetTokenCall()
        map[call.getMethodName()] = call
        call = SaveTokenCall()
        map[call.getMethodName()] = call
        call = GetUserCall()
        map[call.getMethodName()] = call
        call = SaveUserCall()
        map[call.getMethodName()] = call
        map
    }

    override fun dispatch(call: MethodCall, result: MethodChannel.Result) {
        if (calls.containsKey(call.method).not()) {
            result.notImplemented()
            return
        }
        calls[call.method]?.apply {
            invoke(call, result)
        }
    }

    override fun getChannel() = "mmkv"
}