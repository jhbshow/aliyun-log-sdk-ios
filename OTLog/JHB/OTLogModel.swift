//
//  OTLog.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation

@objc open class OTLogModel:NSObject{
    
    public var mContent:NSMutableDictionary = [:]
    public override init(){
        mContent[KEY_TIME] = Int(Date().timeIntervalSince1970) as AnyObject?
    }
    
    @objc open func putLogContent(_ key:String,value:String){
        mContent[key] = value as AnyObject?
    }
}





