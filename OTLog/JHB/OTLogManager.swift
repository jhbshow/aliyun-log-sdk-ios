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
    @objc open func postLog(_ logGroup:OTLogGroupModel,logLevel:OTLogLevel=OTLogLevel.warn,call: @escaping (OTPostLogResult) -> ()){
        let lowestLevel = self.logConfig?.logLowestLevel ?? OTLogLevel.off
        if(lowestLevel != OTLogLevel.off && logLevel.rawValue >= lowestLevel.rawValue){
            //只有不是关闭状态 && 大于等于最低等级的才会上传
            saveLog(logGroupModel: logGroup) {[weak self] (isInDb, saveError) in
                self?.logClient?.PostLog(logGroup.convertToLogGroup(), logStoreName: self?.logConfig?.logStoreName ?? "", call: {(response, error) in
                    if(error == nil){
                        //上传成功
                        if(isInDb){
                            //从Db删除
                            self?.deleteLog(logGroupModel: logGroup)
                        }else{
                            //从本地文件删除
                            self?.deleteLogFromLocal(logGroupModel: logGroup)
                        }
                    }
                    let result = OTPostLogResult(response: response, error: error)
                    call(result)
                })
            }
        }
        
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
    @objc open func saveLog(logGroupModel:OTLogGroupModel,call: @escaping (Bool, Error?) -> ()){
        OTSqliteManager.saveLogToDB(logGroupModel: logGroupModel) {[weak self] (isSuccess, error) in
            if(!isSuccess){
                //保存失败
                logGroupModel.saveCount = logGroupModel.saveCount + 1
                if(logGroupModel.saveCount >= 2){
                    //保存三次失败,保存到本地
                    DispatchQueue.main.async {
                        //主线程，防止线程问题
                        let _ = OTSqliteManager.saveLogToLocal(logGroupModel: logGroupModel)
                         call(false,nil)
                    }
                }else{
                    self?.saveLog(logGroupModel: logGroupModel,call: call)
                }
            }else{
                call(isSuccess,error)
            }
        }
    }
    
    //MARK:- 删除日志
    @objc open func deleteLog(logGroupModel:OTLogGroupModel){
        OTSqliteManager.deleteLog(logGroupModel: logGroupModel)
    }
    
    //MARK:- 删除日志从本地
    func deleteLogFromLocal(logGroupModel:OTLogGroupModel?=nil,localLogDict:[String:Any]? = nil) {
        OTSqliteManager.deleteLogFromLocal(logGroupModel: logGroupModel,localLogDict: localLogDict)
    }
    
    
}
