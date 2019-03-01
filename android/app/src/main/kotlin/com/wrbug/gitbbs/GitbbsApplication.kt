package com.wrbug.gitbbs

import com.tencent.mmkv.MMKV

import io.flutter.app.FlutterApplication

class GitbbsApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        MMKV.initialize(this)
    }
}
