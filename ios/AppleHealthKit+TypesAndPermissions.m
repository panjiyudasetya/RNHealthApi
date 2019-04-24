//
//  AppleHealthKit+TypesAndPermission.m
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 22/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit+TypesAndPermissions.h"
#import "Constants.h"
#import <Foundation/Foundation.h>
#import <HealthKit/HKObjectType.h>
#import <HealthKit/HKStatisticsQuery.h>
#import <HealthKit/HKUnit.h>

@implementation AppleHealthKit(TypesAndPermissions)

- (NSDictionary<NSString*, HKQuantityType*> *)quantityTypes {
  return @{DTStepCount: [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], DTDistanceWalkingRunning: [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]};
}

- (NSDictionary<NSString*, HKUnit*> *)quantityUnits {
  return @{DTStepCount: [HKUnit countUnit], DTDistanceWalkingRunning: [HKUnit meterUnit]};
}

// Unlike FitApi on Android which has an ability to show permission popup multiple times,
// HealthKit wont be able to show permission popup once again after grant some permission
// for particular data type. In that case, we need to ask for read permission for all
// data type in one go.
- (NSSet *)getReadPermissions:(NSArray<NSString *> * _Nonnull)dataTypes; {
  NSDictionary *readPermDict = [self quantityTypes];
  NSMutableSet *readPermSet = [NSMutableSet setWithCapacity:1];
  
  for (NSString* dataType in dataTypes) {
    HKObjectType *value = readPermDict[dataType];
    if(value != nil) {
      [readPermSet addObject:value];
    }
  }
  return readPermSet;
}

@end
