//
//  AppleHealthKit+Queries.m
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 23/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import "AppleHealthKit+Queries.h"
#import <Foundation/Foundation.h>
#import <HealthKit/HKQuantity.h>
#import <HealthKit/HKStatisticsQuery.h>

@implementation AppleHealthKit(Queries)

- (void)fetchSumOfSamplesForType:(HKQuantityType *)quantityType
                       predicate:(NSPredicate*)predicate
                            unit:(HKUnit *)unit
                      completion:(void (^)(double, NSError *))completionHandler {
  
  HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
    HKQuantity *sum = [result sumQuantity];
    if (completionHandler) {
      double value = [sum doubleValueForUnit:unit];
      completionHandler(value, error);
    }
  }];
  
  [self.healthStore executeQuery:query];
}

@end
