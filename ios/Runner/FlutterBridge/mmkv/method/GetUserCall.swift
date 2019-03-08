//
//  GetTokenCall.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
class GetUserCall: MethodCall {
    func getMethodName() -> String {
        return "getUser"
    }
    
     func invoke(call: FlutterMethodCall, result: (Any?) -> Void) {
        result(UserKv.getUser())
    }
}
