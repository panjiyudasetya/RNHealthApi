//
//  RNHealthApi.h
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 12/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNHealthApi, NSObject)

RCT_EXTERN_METHOD(hasPermissionsFor:(NSArray<NSString *> * _Nonnull)dataTypes, resolve:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject);

RCT_EXTERN_METHOD(askPermissionFor:(NSArray<NSString *> * _Nonnull)dataTypes, resolve:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject);

RCT_EXTERN_METHOD(getStepCountToday:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject);

RCT_EXTERN_METHOD(disconnect:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject);

+ (BOOL) requiresMainQueueSetup {
    return false;
}

@end
