//
//  Permissions.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import HealthKit

@objc(HKPermissionsApi)
class HKPermissionsApi: NSObject {
    static let quantiyTypes: [String: HKSampleType] = [
        DataType.stepCount: HKObjectType.quantityType(forIdentifier: .stepCount)!,
        DataType.distanceWalkingRunning: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
    ]
    
    static let quantityUnits: [HKQuantityTypeIdentifier: HKUnit] = [
        HKQuantityTypeIdentifier.stepCount: HKUnit.count(),
        HKQuantityTypeIdentifier.distanceWalkingRunning: HKUnit.meter()
    ]
    
    // Unlike FitApi on Android which has an ability to show permission popup multiple times,
    // HealthKit wont be able to show permission popup once again after grant some permission
    // for particular data type. In that case, we need to ask for read permission for all
    // data type in one go.
    static let readPermissions: [String: HKSampleType] = quantiyTypes
}
