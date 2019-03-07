//
//  FlutterBridge.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class FlutterBridge {
    var channels = [FlutterChannel]();
    init() {
        self.channels.append(MmkvFlutterChannel.init())
    }
    func inject( controller:FlutterViewController)  {
        channels.forEach { (channel) in
            channel.inject(controller: controller)
        }
    }
}
