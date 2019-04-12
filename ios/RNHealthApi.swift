//
//  RNHealthApi.swift
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

@objc(RNHealthApi)
class RNHealthApi: RCTBridge {
    let healthApi = HealthKitApi()
    
    @objc func hasPermissionsFor(_ dataTypes: [String], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        healthApi.hasPermissionsFor(
            dataTypes,
            onSuccess:{ (message: String?) in
                resolve(true)
            },
            onError:{ (error: NSError) in
                reject("PERMISSIONS_ARE_NOT_GRANTED", "Permission are not granted", error)
            })
    }
    
    @objc func askPermissionsFor(_ dataTypes: [String], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        healthApi.askPermissionsFor(
            dataTypes,
            onSuccess:{ (message: String?) in
                resolve("CONNECTED_TO_HEALTH_API")
        },
            onError:{ (error: NSError) in
                reject("REQUEST_CONNECTION_TO_HEALTH_API_FAILED", "Request connection to Health Api failed.", error)
        })
    }
    
    @objc func disconnect(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        healthApi.disconnect(
            onSuccess:{ (message: String?) in
                resolve("REQUEST_SUCCESS")
            },
            onError:{ (error: NSError) in
                reject("DISCONNECTED_TO_HEALTH_API_FAILED", "Disconnecting from Health Api failed.", error)
            })
    }
}
