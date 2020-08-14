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
                        print("日志上传配置为空")
                        return
                    }
                    let timestamp = Date.timeIntervalSinceReferenceDate
                    let logString = logGroupModel.convertToLogGroup().GetJsonPackage();
                    try db.executeUpdate(sls_sql_insert_records, values: [logConfig.endPoint, logConfig.projectName, logConfig.logStoreName, logString, timestamp])
                    logGroupModel.sqliteId =  String(format: "%d", db.lastInsertRowId)
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
     删除日志
     */
    class func deleteLog(logGroupModel:OTLogGroupModel?){
        guard let logId = logGroupModel?.sqliteId else {
            return
        }
        DispatchQueue.global().async {
            dbManager.dbQueue?.inDatabase({ (db) in
                do{
                    let sql = String(format: sls_sql_delete_specific_records, arguments: [logId as CVarArg])
                    try db.executeUpdate(sql, values: nil)
                } catch {
                    print("failed to delete record: \(error.localizedDescription)")
                }
            })
        }
    }
    
    
    /**
     获取本地日志数据
     */
    class func readLocalLogs()->[String]{
        let logArray = NSArray(contentsOfFile: localFilePath)
        return (logArray ?? []) as! [String]
    }
    
    //MARK:- 删除日志从本地
   class func deleteLogFromLocal(logGroupModel:OTLogGroupModel) {
        DispatchQueue.main.async {
            var dataArray = OTSqliteManager.readLocalLogs()
            var newDataArray:NSMutableArray = []
            newDataArray.write(toFile: OTSqliteManager.localFilePath, atomically: true)
            DispatchQueue.global().async {
                
                let newLogString = logGroupModel.convertToLogGroup().GetJsonPackage()
                for (index,logString) in dataArray.enumerated() {
                    if(logString == newLogString){
                        dataArray.remove(at: index)
                        break
                    }
                }
                //回到主线程
                DispatchQueue.main.async {
                    newDataArray = NSMutableArray(array: OTSqliteManager.readLocalLogs())
                    newDataArray.addObjects(from: dataArray)
                    newDataArray.write(toFile: OTSqliteManager.localFilePath, atomically: true)
                }
            }
        }
        
    }
    
}
