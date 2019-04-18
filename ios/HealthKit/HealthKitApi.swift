//
//  HealthKitApi.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import HealthKit

public class HealthKitApi: NSObject {
    let healthStore = HKHealthStore()
    
    func hasPermissionsFor(_ dataTypes: [String], onSuccess completion: @escaping (_ message: String?) -> Void, onError errorHandler: @escaping (_ error: NSError?) -> Void) {
        // HealthKit doesn't have any functionality to check existing permission of particular data types. In this case, we simple call success completion handler
        
        completion(nil)
    }
    
    func askPermissionsFor(_ dataTypes: [String], onSuccess completion: @escaping (_ message: String?) -> Void, onError errorHandler: @escaping (_ error: NSError?) -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            let typeSet = Set(dataTypes.compactMap { HKPermissionsApi.readPermissions[$0] })
            healthStore.requestAuthorization(toShare: nil, read: typeSet) {
                (success, error) in
                
                guard error == nil, success == true else {
                    errorHandler(NSError(
                        domain:"Error while requesting permissions!",
                        code:1,
                        userInfo: error as? [String : Any])
                    )
                    return
                }
                
                completion(nil)
            }
            return
        }
        
        errorHandler(NSError(domain:"Health data is not available!", code:1))
    }
    
    func disconnect(onSuccess completion: @escaping (_ message: String?) -> Void, onError errorHandler: @escaping (_ error: NSError?) -> Void) {
        // HealthKit doesn't have any functionality to unauthorize error. In this case, we simple call success completion handler
        
        completion(nil)
    }
}
