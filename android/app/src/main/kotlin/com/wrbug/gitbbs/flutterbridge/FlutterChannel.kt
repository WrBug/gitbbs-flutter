package com.wrbug.gitbbs.flutterbridge

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

abstract class FlutterChannel {
    companion object {
        private const val prefix = "com.wrbug.gitbbs"
    }

    private val handler = MethodChannel.MethodCallHandler { p0, p1 ->
        dispatch(p0, p1)
    }

    fun inject(messenger: BinaryMessenger) {
        Log.i("aaaaaa", "注入${getChannel()}")
        MethodChannel(messenger, prefix + "/" + getChannel()).setMethodCallHandler(handler)
    }

    abstract fun getChannel(): String
    abstract fun dispatch(call: MethodCall, result: MethodChannel.Result)
}