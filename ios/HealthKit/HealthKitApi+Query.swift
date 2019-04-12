//
//  HealthKitApi+Query.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import HealthKit

extension HealthKitApi {
    
    internal func querySum(forType type: HKQuantityType, predicate: NSPredicate, unit: HKUnit, completion: @escaping (Int?, Date?, Date?, Error?) -> Void) {
        
        // Setting up Statistics query for sum
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum){
            (query, queryResult, error) in
            // This callback will be called when execution of the statistics query is completed.
            
            // Error check:
            guard error == nil, let result = queryResult else {
                completion(nil, nil, nil, error)
                return
            }
            
            // Handling Success case:
            guard let value = result.sumQuantity()?.doubleValue(for: unit) else {
                // When the sumQuantity is nil, then startDate, endDate is nil
                // And accessing the property causes crash
                completion(0, nil, nil, nil)
                return
            }
            
            let sum = Int(round(value))
            
            completion(sum, result.startDate, result.endDate, nil)
        }
        
        healthStore.execute(query)
    }
}
