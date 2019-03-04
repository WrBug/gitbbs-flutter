package com.wrbug.gitbbs

import android.os.Bundle
import android.widget.Toast
import com.tencent.mmkv.MMKV
import com.wrbug.gitbbs.flutterbridge.FlutterBridge

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        FlutterBridge(flutterView).inject()
    }
}
