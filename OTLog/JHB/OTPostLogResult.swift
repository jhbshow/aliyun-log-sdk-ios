//
//  OTPostLogResult.swift
//  OTLog
//
//  Created by cuirhong on 2020/6/24.
//  Copyright © 2020 cuirhong. All rights reserved.
//

import Foundation

@objc open class OTPostLogResult:NSObject{
    
    @objc open var error:NSError? =  nil
    
    @objc open var response:URLResponse? = nil
    
    public init(response:URLResponse?,error:NSError?) {
        super.init()
        self.response = response;
        self.error = error;
    }
    
}



