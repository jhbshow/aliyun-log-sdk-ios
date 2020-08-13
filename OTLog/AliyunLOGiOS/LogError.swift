//  LogError.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation

public enum LogError: Error{
    case nullEndPoint
    case nullAKID
    case nullAKSecret
    case nullToken
    case illegalValueTime
    case nullKey
    case nullValue
    case null
    case nullProjectName
    case nullLogStoreName
    case wrongURL
    //添加服务器返回的错误信息，对外暴露requestID
    case ServiceError(errorCode:String, errorMessage:String, requesetID:String)
}
