package com.wrbug.gitbbs.mmkv

import com.tencent.mmkv.MMKV

object UserKv {
    private val userMmkv = MMKV.mmkvWithID("user")
    fun getToken(): String = userMmkv.getString("token", "") ?: ""
    fun saveToken(token: String) = userMmkv.putString("token", token)
}