//
//  OTLogManager.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation

@objc open class OTLogManager:NSObject{
    /**
     上传日志客户端
     */
    var logConfig:OTLogConfig?
    
    /**
     上传日志客户端
     */
    var logClient:LOGClient?
    
    /**
     单列
     */
    @objc public static let sharedInstance = OTLogManager()
    
    /**
     缓存日志
     */
    private var cacheLogManager:CacheCheckManager? = nil
    
    
    
    /**
     初始化
     */
    @objc public func setupConfig(logConfig:OTLogConfig){
        
        self.logConfig = logConfig
        self.logClient = LOGClient(endPoint: logConfig.endPoint, accessKeyID: logConfig.accessKeyID, accessKeySecret: logConfig.accessKeySecret, projectName: logConfig.projectName, token: logConfig.token, config: logConfig.config)
    }
    
    
    /**
     上传日志
     */
    @objc open func postLog(_ logGroup:OTLogGroupModel,call: @escaping (OTPostLogResult) -> ()){
        
        logClient?.PostLog(logGroup.convertToLogGroup(), logStoreName: logConfig?.logStoreName ?? "", call: { (response, error) in
            let result = OTPostLogResult(response: response, error: error)
            call(result)
        })
    }
   
    /**
     开始上传本地日志(30秒上传一次)
     */
    @objc open func startUploadLog(timeInterval:Int=30){
        if let client = logClient{
            if(cacheLogManager == nil){
                cacheLogManager =  CacheCheckManager.init(timeInterval: timeInterval, client: client, fetchCount: 30)
            }
            cacheLogManager?.startCacheCheck()
        }
    }
    
    /**
     保存日志
     */
    @objc open func saveLog(logGroupModel:OTLogGroupModel){
        OTSqliteManager.saveLogToDB(logGroupModel: logGroupModel) {[weak self] (isCussful, error) in
            if(!isCussful){
                //保存失败
                logGroupModel.saveCount = logGroupModel.saveCount + 1
                if(logGroupModel.saveCount >= 2){
                    //保存三次失败
                   let _ = OTSqliteManager.saveLogToLocal(logGroupModel: logGroupModel)
                }else{
                    self?.saveLog(logGroupModel: logGroupModel)
                }
            }else{
                print("保存日志失败")
            }
        }
        
    }
    
    
}
