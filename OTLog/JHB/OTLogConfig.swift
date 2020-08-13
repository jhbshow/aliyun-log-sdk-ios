//
//  OTLogConfig.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation
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
