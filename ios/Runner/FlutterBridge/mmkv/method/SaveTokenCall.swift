//
//  GetTokenCall.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
class SaveTokenCall: MethodCall {
    func getMethodName() -> String {
        return "saveToken"
    }
    
     func invoke(call: FlutterMethodCall, result: (Any?) -> Void) {
        var args =  call.arguments as! Dictionary<String, Any>
        UserKv.saveToken(args["token"]as! String)
        result(true)
    }
}
