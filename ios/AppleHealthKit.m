//
//  AppleHealthKit.m
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 22/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import "AppleHealthKit+TypesAndPermissions.h"
#import "AppleHealthKit+StepCount.h"
#import <Foundation/Foundation.h>
#import <HealthKit/HKHealthStore.h>

@implementation AppleHealthKit

@synthesize healthStore;

- (instancetype)init{
  self = [super init];
  if (self) {
    self.healthStore = [[HKHealthStore alloc] init];
  }
  return self;
}

- (void)hasPermissionsFor:(NSArray<NSString *> * _Nonnull)dataTypes completion:(void (^)(BOOL, NSError * _Nullable))completion {
  if (HKHealthStore.isHealthDataAvailable) {
    completion(true, nil);
    return;
  }
  [self onHealthNotAvailable:completion];
}

- (void)askPermissionFor:(NSArray<NSString *> * _Nonnull)dataTypes completion:(void (^)(BOOL, NSError * _Nullable))completion {
  if (HKHealthStore.isHealthDataAvailable) {
    NSSet* readPermsArray = [self getReadPermissions:dataTypes];
    [healthStore requestAuthorizationToShareTypes:nil
                                        readTypes:readPermsArray
                                       completion:completion];
    return;
  }
  [self onHealthNotAvailable:completion];
}

- (void)getStepCountToday: (void (^)(double value, NSError* _Nullable error))completion {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
  dateComponents.day = 1;
  dateComponents.second = -1;
  
  NSDate *startDate = [calendar startOfDayForDate:[NSDate date]];
  NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
  [self getSumStepCount:startDate endDate:endDate completion:completion];
}

- (void)disconnect:(void (^)(BOOL, NSError * _Nullable))completion {
  if (HKHealthStore.isHealthDataAvailable) {
    completion(true, nil);
    return;
  }
  [self onHealthNotAvailable:completion];
}

- (void)onHealthNotAvailable:(void (^)(BOOL, NSError * _Nullable))completion{
  NSString *domain = [HKErrorDomain initWithString:@"HKErrorDomain"];
  NSDictionary<NSString *, id> *userInfo = @{@"Health data is not available!": @1};
  completion(false, [[NSError alloc] initWithDomain:domain code:1 userInfo: userInfo]);
}
     
@end
