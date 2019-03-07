//
//  FlutterMethodCall.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter
protocol MethodCall {
    func  getMethodName() -> String;
    func invoke(call: FlutterMethodCall, result: (Any?) -> Void);
}
