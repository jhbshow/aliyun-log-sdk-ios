//
//  OTLogConfig.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation
//日志等级
@objc public enum OTLogLevel:Int {
    case all = 0;
    case trace;
    case debug;
    case info;
    case warn;
    case error;
    case fatal;
    case mark;
    case off;
}

@objc open class OTLogConfig: NSObject {
    
    var endPoint:String = ""
    
    var accessKeyID:String = ""
    
    var accessKeySecret:String = ""
    
    var projectName:String = ""
    
    var token:String?
    
    var logStoreName:String = ""
    
    /**
     阿里云SLS配置
     */
    var config: SLSConfig = SLSConfig()

    //MARK:- 日志最低等级(只有大于这个等级才记录日志,默认记录警告以上的日志)
    @objc public var logLowestLevel:OTLogLevel = OTLogLevel.warn
    
    @objc public init(endPoint:String,accessKeyID:String,accessKeySecret :String,projectName:String,logStoreName:String, token: String? = nil){
        super.init()
        self.endPoint = endPoint
        self.accessKeyID = accessKeyID
        self.accessKeySecret = accessKeySecret
        self.projectName = projectName
        self.logStoreName = logStoreName
        self.token = token
     }
}
