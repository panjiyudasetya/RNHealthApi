//
//  RNExHealth.m
//  HealthApiPlayground
//
//  Created by Panji Y. Wiwaha on 22/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import "RNHealthApi.h"
#import <Foundation/Foundation.h>

@implementation RNHealthApi

@synthesize healthKit;

- (instancetype)init{
  self = [super init];
  if (self) {
    self.healthKit = [[AppleHealthKit alloc] init];
  }
  return self;
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(hasPermissionsFor:(NSArray<NSString *> * _Nonnull)dataTypes resolve:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject) {
  [healthKit hasPermissionsFor:dataTypes completion:^(BOOL success, NSError *error) {
    if (success && error == nil) {
      resolve(@"true");
    } else {
      reject(@"PERMISSIONS_ARE_NOT_GRANTED", @"Permission are not granted.", error);
    }
  }];
}

RCT_EXPORT_METHOD(askPermissionFor:(NSArray<NSString *> * _Nonnull)dataTypes resolve:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject) {
  [healthKit askPermissionFor:dataTypes completion:^(BOOL success, NSError *error) {
    if (success && error == nil) {
      resolve(@"true");
    } else {
      reject(@"REQUEST_CONNECTION_TO_HEALTH_SERVICES_FAILED", @"Request connection to Apple Health failed.", error);
    }
  }];
}

RCT_EXPORT_METHOD(getStepCountToday:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject) {
  [healthKit getStepCountToday:^(double value, NSError * _Nullable error) {
    if (error == nil) {
      resolve(@(@(value).intValue));
    } else {
      reject(@"FETCH_STEP_COUNT_DATA_ERROR", @"Failed to get step count!", error);
    }
  }];
}

RCT_EXPORT_METHOD(disconnect:(RCTPromiseResolveBlock _Nonnull)resolve reject:(RCTPromiseRejectBlock _Nonnull)reject) {
  [healthKit disconnect:^(BOOL success, NSError *error) {
    if (success && error == nil) {
      resolve(@"true");
    } else {
      reject(@"DISCONNECTED_FROM_HEALTH_SERVICES_FAILED", @"Disconnecting from Health services failed.", error);
    }
  }];
}

+ (BOOL) requiresMainQueueSetup {
  return false;
}

@end
