//
//  UserKv.swift
//  Runner
//
//  Created by WrBug on 2019/3/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import MMKV
class UserKv {
    private static let userKv=MMKV.init(mmapID: "user")
    static func getToken()->String{
        return userKv?.string(forKey: "token") ?? ""
    }
    
    public  static func saveToken(_ token:String){
        userKv?.set(token, forKey: "token")
    }

    
    static func getUser()->String{
        return userKv?.string(forKey: "user") ?? ""
    }
    
    public  static func saveUser(_  user:String){
        userKv?.set(user, forKey: "user")
    }
}
