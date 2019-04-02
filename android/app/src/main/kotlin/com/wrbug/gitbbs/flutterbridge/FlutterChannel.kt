package com.wrbug.gitbbs.flutterbridge

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

abstract class FlutterChannel {
    companion object {
        /// 修改以下参数，务必将flutter和iOS相应值也修改， 建议保持默认
        /// iOS ： ios/Runner/FlutterBridge/FlutterChannel.swift
        /// flutter：lib/constant/NativeBridgeConstant.dart
        private const val prefix = "com.wrbug.gitbbs"
    }

    private val handler = MethodChannel.MethodCallHandler { p0, p1 ->
        dispatch(p0, p1)
    }

    fun inject(messenger: BinaryMessenger) {
        MethodChannel(messenger, prefix + "/" + getChannel()).setMethodCallHandler(handler)
    }

    abstract fun getChannel(): String
    abstract fun dispatch(call: MethodCall, result: MethodChannel.Result)
}