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

- (void)getStepCountToday: (void (^)(double value, NSError* _Nullable error))completion {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 1;
    dateComponents.second = -1;
    
    NSDate *startDate = [calendar startOfDayForDate:[NSDate date]];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    NSPredicate* queryPredicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    [self fetchSumOfSamplesForType:[[self quantityTypes] objectForKey:DTStepCount]
                         predicate:queryPredicate
                              unit:[[self quantityUnits] objectForKey:DTStepCount]
                        completion:completion];
}

@end
