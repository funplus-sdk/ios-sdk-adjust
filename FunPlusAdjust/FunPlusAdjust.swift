//
//  FunPlusAdjust.swift
//  FunPlusSDK
//
//  Created by Yuankun Zhang on 6/22/16.
//  Copyright © 2016 funplus. All rights reserved.
//

import Foundation
import AdjustSdk
import FunPlusSDK

// MARK: - FunPlusAdjust

public class FunPlusAdjust {
    
    // MARK: - Properties
    
    init(appToken: String, environment: String, appOpenEventToken: String) {
        let adjustConfig = ADJConfig(appToken: appToken, environment: environment)
        Adjust.appDidLaunch(adjustConfig)
        
        trackEvent(eventToken: appOpenEventToken)
    }
    
    public func trackEvent(eventToken: String) {
        let uid = FunPlusSDK.getFunPlusID().getCurrentFPID()
        if let event = ADJEvent(eventToken: eventToken) {
            event.addCallbackParameter("fpid", value: uid)
            Adjust.trackEvent(event)
        }
    }
}
