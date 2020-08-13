//
//  OTLogGroup.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation
 
@objc open class OTLogGroupModel: NSObject {
    /**
     日志话题
     */
    fileprivate var logTopic:String?
    
    /**
     日志来源
     */
    fileprivate var logSource:String?
    
    /**
     多个日志内容
     */
    fileprivate var logContents:[OTLogModel] = []
    
    /**
     日志tag，一般不用这个
     */
    fileprivate var logTagContentMap:Dictionary<String, Any>?
    
    /**
     保存次数
     */
    open var saveCount:Int = 0
    
    /**
     初始化方法
     */
    @objc public init(logTopic:String?="",logSource:String?="",logContents:[OTLogModel],logTagContentMap:Dictionary<String, Any>?=nil){
        super.init();
        self.logTopic = logTopic
        self.logSource = logSource
        self.logContents = logContents
        self.logTagContentMap = logTagContentMap
    }
    
    /**
     转换从json字符串
    */
    @objc public init(jsonString:String){
       super.init();
        
        if let data = jsonString.data(using: .utf8){
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any] {
//
//                let topic = json[KEY_TOPIC]
//                let source = json[KEY_SOURCE]
//                let logContents = json[KEY_LOGS]
//                print(logContents)
            }
        }
        
    }
    
    
    
    /**
     转换成LogGroup
     */
    open func convertToLogGroup()->LogGroup{
        let newLogGroup = LogGroup(topic: logTopic ?? "", source: logSource ?? "")
        for model in logContents{
            let newLogModel = Log();
            newLogModel.mContent = model.mContent
    
            newLogGroup.PutLog(newLogModel)
        }
        return newLogGroup
    }
    
 
 
    open func getSource()->String{
        return logSource ?? ""
    }
    
}
