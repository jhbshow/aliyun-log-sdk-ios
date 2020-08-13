//  SLSConfig.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/15.
//  Copyright © 2020 cuirhong. All rights reserved.
//


import Foundation

open class SLSConfig: NSObject {
    @objc
    public enum SLSConnectionType: Int{
        case wifi
        case wifiOrwwan
    }
    /// 是否开启离线缓存日志功能,默认不开启
    fileprivate var mCachable: Bool = false;
    
    
    /// 离线日志的发送时机,默认是只在wifi网络状况下发送
    fileprivate var mConnectType: SLSConnectionType;
    
    open var isCachable: Bool {
        return mCachable
    }
    
    open var connectType: SLSConnectionType {
        return mConnectType
    }
    
    public init(connectType: SLSConnectionType = .wifi, cachable: Bool = false) {
        mCachable = cachable
        mConnectType = connectType
    }
}
