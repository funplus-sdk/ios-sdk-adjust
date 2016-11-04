//
//  FunPlusAdjust.swift
//  FunPlusSDK
//
//  Created by Yuankun Zhang on 6/22/16.
//  Copyright © 2016 funplus. All rights reserved.
//

import Foundation
import AdjustSdk

// MARK: - FunPlusAdjust

public class FunPlusAdjust {
    
    // MARK: - Properties
    
    let funPlusConfig: FunPlusConfig
    let adjustEnabled: Bool
    let appOpenEventToken: String
    
    init(funPlusConfig: FunPlusConfig) {
        self.funPlusConfig = funPlusConfig
        self.adjustEnabled = funPlusConfig.adjustEnabled
        self.appOpenEventToken = funPlusConfig.adjustAppOpenEventToken
        
        if adjustEnabled {
            let appToken = funPlusConfig.adjustAppToken
            let environment = funPlusConfig.environment.rawValue
            let adjustConfig = ADJConfig(appToken: appToken, environment: environment)
            Adjust.appDidLaunch(adjustConfig)
        
            trackAppOpenEvent()
        }
    }
    
    public func trackAppOpenEvent() {
        if adjustEnabled {
            let sessionManager = FunPlusFactory.getSessionManager(funPlusConfig: funPlusConfig)
        
            if let event = ADJEvent(eventToken: appOpenEventToken) {
                event.addCallbackParameter("fpid", value: sessionManager.userId)
                Adjust.trackEvent(event)
            }
        }
    }
}
