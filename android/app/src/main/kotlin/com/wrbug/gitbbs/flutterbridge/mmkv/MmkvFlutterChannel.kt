package com.wrbug.gitbbs.flutterbridge.mmkv

import com.wrbug.gitbbs.flutterbridge.FlutterChannel
import com.wrbug.gitbbs.flutterbridge.FlutterMethodCall
import com.wrbug.gitbbs.flutterbridge.mmkv.method.GetTokenCall
import com.wrbug.gitbbs.flutterbridge.mmkv.method.SaveTokenCall
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.HashMap

class MmkvFlutterChannel : FlutterChannel() {
    val calls: Map<String, FlutterMethodCall> by lazy {
        val map = HashMap<String, FlutterMethodCall>()
        val getTokenCall = GetTokenCall()
        map[getTokenCall.getMethodName()] = getTokenCall
        val saveTokenCall = SaveTokenCall()
        map[saveTokenCall.getMethodName()] = saveTokenCall
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