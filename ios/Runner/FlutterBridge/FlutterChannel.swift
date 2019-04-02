//
//  FlutterChannel.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter

/// 修改以下参数，务必将flutter和iOS相应值也修改， 建议保持默认
/// android ： android/app/src/main/kotlin/com/wrbug/gitbbs/flutterbridge/FlutterChannel.kt
/// flutter：lib/constant/NativeBridgeConstant.dart
let prefix:String="com.wrbug.gitbbs";
class FlutterChannel {
    
    
    func handler() -> FlutterMethodCallHandler{
        return {(call, result ) in
            self.dispatch(call , result);
        }
    }
    func inject(controller:FlutterViewController)  {
        FlutterMethodChannel.init(name: prefix+"/"+getChannel(),binaryMessenger:controller)
        .setMethodCallHandler(handler())
    }
    func  dispatch(_ call:  FlutterMethodCall,_ result: FlutterResult){}
    
    func getChannel() -> String {
        return "";
    }
}
