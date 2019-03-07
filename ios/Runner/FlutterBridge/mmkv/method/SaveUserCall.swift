//
//  GetTokenCall.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
class SaveUserCall: MethodCall {
    func getMethodName() -> String {
        return "saveUser"
    }
    
     func invoke(call: FlutterMethodCall, result: (Any?) -> Void) {
        var args =  call.arguments as! Dictionary<String, Any>
        UserKv.saveUser(args["user"]as! String)
        result(true)
    }
}
