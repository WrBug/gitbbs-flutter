//
//  GetTokenCall.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
class GetTokenCall: MethodCall {
    func getMethodName() -> String {
        return "getToken"
    }
    
     func invoke(call: FlutterMethodCall, result: (Any?) -> Void) {
        result(UserKv.getToken())
    }
}
