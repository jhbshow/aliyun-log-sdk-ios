//
//  OTSqliteManager.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/24.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation

class OTSqliteManager:NSObject{
    
    private static let dbManager = DBManager.defaultManager()
    
    private static let localFilePath = NSHomeDirectory() + "/Documents/jhblog.plist"
    
    /**
     保存到DB
     */
    class func saveLogToDB(logGroupModel:OTLogGroupModel,call: @escaping (Bool, Error?) -> ()){
        
        DispatchQueue.global().async {
            dbManager.dbQueue?.inDatabase({ (db) in
                do {
                    guard let logConfig = OTLogManager.sharedInstance.logConfig else {
                        NSLog("%@", "日志上传配置为空");
                        return
                    }
                    let timestamp = Date.timeIntervalBetween1970AndReferenceDate
                    let logString = logGroupModel.convertToLogGroup().GetJsonPackage();
     
                    try db.executeUpdate(sls_sql_insert_records, values: [logConfig.endPoint, logConfig.projectName, logConfig.logStoreName, logString, timestamp])
                    call(true,nil)
                } catch {
                     call(false,nil)
                }
            })
        }
    }
    
    /**
     保存到本地文件
     */
    class func saveLogToLocal(logGroupModel:OTLogGroupModel)->Bool{
        let dataArray = NSMutableArray(array: OTSqliteManager.readLocalLogs());
        dataArray.add(logGroupModel.convertToLogGroup().GetJsonPackage())
        let success = dataArray.write(toFile: localFilePath, atomically: true)
        return success
    }
    
    
    /**
     获取本地日志数据
     */
    class func readLocalLogs()->NSArray{
        let logArray = NSArray(contentsOfFile: localFilePath)
        return logArray ?? []
    }
     
}
