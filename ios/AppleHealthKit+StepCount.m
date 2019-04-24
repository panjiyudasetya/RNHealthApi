//
//  AppleHealthKit+StepCount.m
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 23/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit+Queries.h"
#import "AppleHealthKit+StepCount.h"
#import "AppleHealthKit+TypesAndPermissions.h"
#import "Constants.h"
#import <Foundation/Foundation.h>
#import <HealthKit/HKQuery.h>

@implementation AppleHealthKit (StepCount)

- (void)getSumStepCount:(NSDate*)startDate
                endDate:(NSDate*)endDate
             completion:(void (^)(double value, NSError* _Nullable error))completion {

  NSPredicate* queryPredicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
  [self fetchSumOfSamplesForType:[[self quantityTypes] objectForKey:DTStepCount]
                                      predicate:queryPredicate
                                           unit:[[self quantityUnits] objectForKey:DTStepCount]
                                     completion:completion];
}

@end
