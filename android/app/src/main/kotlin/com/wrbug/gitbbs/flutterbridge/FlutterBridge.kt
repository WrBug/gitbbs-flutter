package com.wrbug.gitbbs.flutterbridge

import com.wrbug.gitbbs.flutterbridge.mmkv.MmkvFlutterChannel
import io.flutter.plugin.common.BinaryMessenger

class FlutterBridge(val messenger: BinaryMessenger) {
    private val channels: Array<FlutterChannel> by lazy {
        val arr: Array<FlutterChannel> = arrayOf(MmkvFlutterChannel())
        arr
    }


    fun inject() {
        channels.forEach {
            it.inject(messenger)
        }
    }
}