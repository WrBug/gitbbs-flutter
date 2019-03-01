package com.wrbug.gitbbs.flutterbridge

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

interface FlutterMethodCall {
    fun getMethodName(): String
    fun invoke(call: MethodCall, result: MethodChannel.Result)
}