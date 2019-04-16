//
//  RNHealthApi+StepCount.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

extension RNHealthApi {
    
    @objc(getStepCountToday:reject:)
    func getStepCountToday(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        healthApi.getStepCountToday(
            onResult: {
                (value) in
                resolve(value)
        },
            onError: {
                (error) in
                reject("FETCH_STEP_COUNT_DATA_ERROR", "Failed to get step count!", error)
        })
    }
}
