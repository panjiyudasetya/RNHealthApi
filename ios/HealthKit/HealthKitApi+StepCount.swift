//
//  HealthKitApi+StepCount.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import HealthKit

extension HealthKitApi {
    @objc func getStepCountToday(onResult completion:@escaping (_ total: Int) -> Void, onError errorHandler: @escaping (_ error: Error?) -> Void) {
        
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(
            withStart: Date().startOfDay,
            end: Date().endOfDay,
            options: .strictEndDate
        )
        
        let unit = HKPermissionsApi.quantityUnits[.stepCount]
        querySum(forType: stepCountType, predicate: predicate, unit: unit!) {
            (value, start, end, error) in
            
            // Error Check:
            guard error == nil else {
                errorHandler(NSError(
                    domain:"Failed to get step count!",
                    code:1,
                    userInfo: error as? [String : Any])
                )
                return
            }
            
            guard value != nil, start != nil, end != nil else {
                // HK does not provide start, end if there is no value is registered today.
                // So we need to use the startDate and endDate given in the query.
                completion(0)
                return
            }
            
            completion(value!)
        }
    }
}
