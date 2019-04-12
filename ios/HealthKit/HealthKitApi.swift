//
//  HealthKitApi.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import HealthKit

@objc(HealthKitApi)
class HealthKitApi: NSObject {
    let healthStore = HKHealthStore()
    
    @objc func hasPermissionsFor(_ dataTypes: [String], onSuccess completion: @escaping (_ message: String?) -> Void, onError errorHandler: @escaping (_ error: NSError?) -> Void) {
        // HealthKit doesn't have any functionality to check existing permission of particular data types. In this case, we simple call success completion handler
        
        completion()
    }
    
    @objc func askPermissionsFor(_ dataTypes: [String], onSuccess completion: @escaping (_ message: String?) -> Void, onError errorHandler: @escaping (_ error: NSError?) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            let typeSet = Set(dataTypes.compactMap { HKPermissionsApi.readPermissions[$0] })
            healthStore.requestAuthorization(toShare: nil, read: typeSet) {
                (success, error) in
                
                guard error == nil, success == true else {
                    errorHandler(NSError(
                        code:1,
                        message:"Error while requesting permissions!",
                        error: error)
                    )
                    return
                }
                
                completion()
            }
            return
        }
        
        errorHandler(NSError(code:1, message:"Health data is not available!"))
    }
    
    @objc func disconnect(onSuccess completion: @escaping (_ message: String?) -> Void, onError errorHandler: @escaping (_ error: Error?) -> Void) {
        // HealthKit doesn't have any functionality to unauthorize error. In this case, we simple call success completion handler
        
        completion()
    }
}
