//
//  MmkvFlutterChannel.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
class  MmkvFlutterChannel: FlutterChannel {
    var calls=[String:MethodCall]();
    override init() {
        var call:MethodCall=GetUserCall.init()
        calls[call.getMethodName()]=call
         call=SaveUserCall.init()
        calls[call.getMethodName()]=call
         call=GetTokenCall.init()
        calls[call.getMethodName()]=call
         call=SaveTokenCall.init()
        calls[call.getMethodName()]=call
    }
    override func getChannel() -> String {
        return "mmkv"
    }
    override func dispatch(_ call: FlutterMethodCall, _ result: (Any?) -> Void) {
        let methodCall=calls[call.method]
        if(methodCall != nil){
            methodCall?.invoke(call: call, result: result)
            return
        }
        result(FlutterMethodNotImplemented)
    }
}
